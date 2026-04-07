classdef ImageClassifier
    properties
        ImageDatastoreObj  % Datastore for image data
        TrainingImages     % Training image datastore
        TestingImages      % Testing image datastore
        DeepNetwork        % Pretrained deep learning network
        FeatureLayer       % Layer for feature extraction
        TrainedSVM         % Trained SVM classifier
    end

    methods
        %% Constructor Method
        function obj = ImageClassifier(imageFolderPath)
            % Constructor initializes properties and prepares the dataset
            clc;
            disp('*** Image Classification Using Deep Learning ***');

            % Load image datastore
            obj.ImageDatastoreObj = imageDatastore(imageFolderPath, 'LabelSource', 'foldernames', 'IncludeSubfolders', true);
            obj.ImageDatastoreObj.ReadFcn = @ImageClassifier.customReader;
            
            % Display dataset label counts
            labelCounts = countEachLabel(obj.ImageDatastoreObj);
            disp('Image count per category:');
            disp(labelCounts);

            % Partition dataset into training and testing sets
            [obj.TrainingImages, obj.TestingImages] = splitEachLabel(obj.ImageDatastoreObj, 0.90, 'randomize');

            % Load pretrained network
            obj.DeepNetwork = resnet50;
            obj.FeatureLayer = obj.DeepNetwork.Layers(end - 2, 1).Name;
            disp(['Using Resnet 50, extracting features from layer: ' obj.FeatureLayer]);
        end

        %% Feature Extraction Method
        function features = extractFeatures(obj, imageSet)
            batchSize = 64;
            networkInputSize = obj.DeepNetwork.Layers(1).InputSize;
            augmentedImages = augmentedImageDatastore(networkInputSize, imageSet, 'ColorPreprocessing', 'gray2rgb');
            features = activations(obj.DeepNetwork, augmentedImages, obj.FeatureLayer, ...
                'MiniBatchSize', batchSize, 'OutputAs', 'columns', 'ExecutionEnvironment', 'auto');
        end

        %% Train SVM Classifier Method
        function obj = trainClassifier(obj)
            disp('Training SVM Classifier...');
            trainingFeatures = obj.extractFeatures(obj.TrainingImages);
            trainingLabels = obj.TrainingImages.Labels;
            obj.TrainedSVM = fitcecoc(trainingFeatures, trainingLabels, ...
                'Learners', 'svm', 'Coding', 'onevsall', 'ObservationsIn', 'columns', 'Verbose', 2);
        end

        %% Test and Evaluate Classifier Method
        function evaluateClassifier(obj)
            disp('Evaluating Classifier...');
            testFeatures = obj.extractFeatures(obj.TestingImages);
            predictedLabels = predict(obj.TrainedSVM, testFeatures, 'ObservationsIn', 'columns');
            trueLabels = obj.TestingImages.Labels;

            % Confusion matrix
            confusionMatrix = confusionmat(trueLabels, predictedLabels);
            confusionchart(trueLabels, predictedLabels);
            disp('Confusion Matrix (Raw Counts):');
            disp(confusionMatrix);

            % Normalize confusion matrix
            normalizedMatrix = bsxfun(@rdivide, confusionMatrix, sum(confusionMatrix, 2));
            disp('Confusion Matrix (Percentage Form):');
            disp(normalizedMatrix);

            % Calculate and display classification accuracy
            accuracy = mean(diag(normalizedMatrix));
            disp(['Overall Classification Accuracy = ' num2str(accuracy)]);
        end

        %% Save Model Method
        function saveModel(obj)
            disp('Saving models...');
            trainedSVMClassifier = obj.TrainedSVM;
            deepNetwork = obj.DeepNetwork;
            save('trainedSVMClassifier', 'trainedSVMClassifier');
            save('deepNetwork', 'deepNetwork');
            disp('Models saved successfully.');
        end
    end

    methods (Static)
        %% Custom Image Reader Function
        function img = customReader(fileName)
            onState = warning('off','backtrace');
            c = onCleanup(@()warning(onState));
            data = imread(fileName);
            data = data(:,:,min(1:3,end));
            img = imresize(data,[256 256]);
        end
    end
end



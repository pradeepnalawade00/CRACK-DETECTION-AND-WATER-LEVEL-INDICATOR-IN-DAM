function [outputLabel,score] = CNNPredict(inputImage)

% Load the pre-trained classifier and deep learning network
loadedClassifier = coder.load('trainedSVMClassifier.mat', 'trainedSVMClassifier');
loadedNetwork = coder.loadDeepLearningNetwork('deepNetwork.mat');

% Identify the feature extraction layer and input size of the network
featureExtractionLayer = loadedNetwork.Layers(end-2,1).Name;
networkInputSize = loadedNetwork.Layers(1).InputSize;

% Resize the input image and extract features using the CNN
imageFeatures = activations(loadedNetwork, imresize(inputImage, networkInputSize(1:2)), featureExtractionLayer);

% Predict the label using the loaded classifier
[predictedClassLabel,~,mpred] = predict(loadedClassifier.trainedSVMClassifier, imageFeatures(:)');

% Return the predicted label as output
outputLabel = cellstr(predictedClassLabel(1));
score = 100-max(mpred);
outputLabel = outputLabel{:};

end

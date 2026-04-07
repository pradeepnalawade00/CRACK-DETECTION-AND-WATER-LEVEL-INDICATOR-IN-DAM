%% Script to Execute the Classification Process
clc;
clear all;
close all force;

% Specify the image dataset path
imageFolder = fullfile(pwd, 'datasets');

% Create an object of ImageClassifier
classifier = ImageClassifier(imageFolder);

% Train the classifier
classifier = classifier.trainClassifier();

% Evaluate the classifier
classifier.evaluateClassifier();

% Save the trained models
classifier.saveModel();
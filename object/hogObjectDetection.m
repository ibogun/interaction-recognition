% Load training and test data
load('digitDataSet.mat', 'trainingImages', 'trainingLabels', 'testImages');

% Update file name relative to matlabroot
dataSetDir     = fullfile(matlabroot,'toolbox','vision','visiondemos');
trainingImages = fullfile(dataSetDir, trainingImages);
testImages     = fullfile(dataSetDir, testImages);
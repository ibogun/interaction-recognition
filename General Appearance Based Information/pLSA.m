%   Give Dataset Folder
%   Give Location Of Images
%   Give Number Of Frames
%   Give Size Of Each image in X and in Y
%   Give the topics you are trying to classify in format cell array
%   ex: {'hand', 'pen', ...}
%   Specify Dictionary Size, numberOfClusters
%   Specify size of patches for Edges
%   Specify size of patches for Doublets

topics={'background','hand'};
xSize=25;
ySize=25;
datasetFolder='/host/Users/ibogun2010/datasets/Gupta/a';
numberOfFrames=1;

numberOfClasses = length(topics);
locationOfImages=cell(1,1);

[objects] = GetDataset(datasetFolder,objects,numberOfFrames, xSize, ySize);

%   Display Object Images to find ground truth
%[objectImages, order] = DisplayObjectImages(objects, topics);

%   Once order is established you can just run this:
%[objectImages] = DisplayObjectImages(objects, categories, order);

%   Find the Edge Magnitudes for the objects
%edgeObjectMagnitudes = CanninizeObjectImages(objectImages);

%   Combine all the patches together to form feature vector
%   Specify whether or not they are edge descriptors or doublets
%   descriptors
%[combinedPatches, ~, ~] = GetGeneralPatches(edgeObjectImages, 15, true, false, topics);

%   This is so that after the K means, we are able to separate out which
%   feature belongs where
%edgeVideoSizes = GetVideoSizes(combinedPatches);

%   Now perform the same steps for doublets
%[~, combinedDoubletPatches, groundTruth] = GetGeneralPatches(objectImages, 5, false, true, topics);
%doubletVideoSizes = GetVideoSizes(combinedDoubletPatches);

%   Using the propagation from Doublets to Edges approach:
%% Get Probabilistic Distribution for Doublets
%   Get Corpus for Doublets
%videos = GetBag(combinedDoubletPatches.allPatches, numberOfClusters, videoSizes);

%   Separate labels into their respective videos and create a frequency
%   vector for each video that will be used for pLSA
% for video = 1 : length(videos)
%     videos{2,video} = zeros(numberOfClusters, 1);
%     for idx = 1 : numberOfClusters
%         videos{2,video}(idx) = sum(videos{1, video} == idx);
%     end
% end

%   combine the frequency vectors for all videos together to make the data
% dataMatrix = zeros(numberOfClusters, length(videos));
%   matrix for pLSA
% for video = 1 : length(videos)
%     dataMatrix(:, video) = videos{2,video};
% end

%   Run PLSA_EM for doublets
% vids = length(groundTruth);
% [Pw_z, doubletsPz_d, Pz, Li] = pLSA_EMmodified(dataMatrix, numberOfClasses, Par);

%% Get Probabilistic Distribution for Edges
%   Get Corpus for Edges
%videos = GetBag(combinedPatches.allPatches, numberOfClusters, edgeVideoSizes);

%   Separate labels into their own respective videos and create a frequency
%   vector for each video that will be used for pLSA
% for video = 1 : length(videos)
%     videos{2,video} = zeros(numberOfClusters, 1);
%     for idx = 1 : numberOfClusters
%         videos{2,video}(idx) = sum(videos{1, video} == idx);
%     end
% end

%   Combine the frequency vectors for all videos together to make the data
%   matrix for pLSA
% dataMatrix = zeros(numberOfClusters, length(videos));
% for video = 1 : length(videos)
%     dataMatrix(:, video) = videos{2,video};
% end

%   Give the probabilities learned from the Doublets, in an unsupervised
%   setting there are no labels that are inputted
%[Pw_z, edgesPz_d, Pz, Li] = pLSA_EMmodified(dataMatrix, numberOfClasses, Par, [], doubletsPz_d);

%% Now we can combine both probabilities learned from Edges and Doublets

% combinedPz_d = edgesPz_d .* doubletsPz_d;
% vids = length(groundTruth);
% predictedLabels = zeros(vids, 1);
% for vid = 1 : vids
%     [~, predictedLabels(vid)] = maxcombinedPz_d(vid, :));
% end
% [missrate, confMatrix, predictedClasses] = Misclassification(predictedLabelsCombined, groundTruth);


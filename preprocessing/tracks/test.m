

sourceFlow='/host/Users/ibogun2010/datasets/Gupta/optical flow/';
listFlow=dir(sourceFlow);

sourceDetections='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(sourceDetections);


listDetections=listDetections(3:end);
listFlow=listFlow(3:end);

% iterate through every video
i=1;

% example : /host/Users/ibogun2010/datasets/Gupta/optical flow/01.mat
flowFilename=strcat(sourceFlow,listFlow(i).name);
detectionFilename=strcat(sourceDetections,listDetections(i).name);
% load the flow
% WARNING: TAKES A LOT OF TIME, LOAD ONLY ONCE!
fprintf('Video # %i \n',i);
if (~exist('flow','var'))
    
    fprintf('Loading optical flow ... ');
    flow=load(flowFilename);
    flow=flow.optFlow;
    fprintf('Done \n');
end



[forwardTracks,forwardMask]=createForwardTracks(flow,detectionFilename,0);
[backwardTracks,backwardMask]=createBackwardTracks(flow,detectionFilename,0);


%%
forwardTracks=extrapolateTracks(forwardTracks,flow,'down',0);
backwardTracks=extrapolateTracks(backwardTracks,flow,'up',0);

forward=tracksToMatrix(forwardTracks);
backward=tracksToMatrix(backwardTracks);

tracks=mergeTracks([forwardTracks;backwardTracks],5);
clearvars -except forwardTracks  backwardTracks tracks;
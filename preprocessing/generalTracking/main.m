clc; close all; clear;
videosFolder='/host/Users/ibogun2010/datasets/Gupta/frames/';

sourceDetections='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(sourceDetections);
listDetections=listDetections(3:end);


listVideos=dir(videosFolder);
listVideos=listVideos(3:end);

% iterate through every video
i=1;

% example : /host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01
% Folder with detections for current video
detectionFilename=strcat(sourceDetections,listDetections(i).name);

detections=dir(detectionFilename);
detections=detections(3:end);

% sort detections (some have xxx1 others xxx23, etc.)
[detections, correctIndices]=sortDetections(detections);



% Folder with frame for current video
currentVideo=strcat(videosFolder,listVideos(i).name,'/');




detectionFrom=load(strcat(detectionFilename,'/',detections(1).name));

% Detection data structure
detectionFrom=detectionFrom.BB;
wrapperTLDforFrameByFrame;


%% Normal probability version 1.0 (Naive)

trajectory(1,1:4)=detectionFrom(1,1:4);
for j=2:69
detectionFrom=load(strcat(detectionFilename,'/',detections(j).name));

% Detection data structure
detectionFrom=detectionFrom.BB;

tld=tldProcessFrame(tld,j);

weights=detectionFrom(:,end);

% generate detection weights
weights=weights/sum(weights);

detectionsBB=round(detectionFrom(:,1:4));
% initialize tld structure

detectionsCenters=[(detectionsBB(:,1)+detectionsBB(:,3))/2, (detectionsBB(:,2)+detectionsBB(:,4))/2];
% find out what this data structure represents?

I=eye(2)*20;
trackingPosition=tld.bb(:,j);

w=abs(trackingPosition(1)-trackingPosition(3));
h=abs(trackingPosition(2)-trackingPosition(4));

conf=tld.conf(j);
trackingCenter=[(trackingPosition(1)+trackingPosition(3))/2,...
    (trackingPosition(2)+trackingPosition(4))/2];


f=@(x) -(sumWeightsNormal(x,weights,detectionsCenters,I))-(conf*mvnpdf(x,trackingCenter,I));

[X, f1]=fminsearch(f,mean(detectionsCenters));
X
f1
trajectory(j,:)=[X(1)-w/2,X(2)-h/2,X(1)+w/2,X(2)+h/2];
%tld.bb(:,j)=trajectory(j,:)';
end
% variable to denote number of frames
[nFrames,~]=size(detections);
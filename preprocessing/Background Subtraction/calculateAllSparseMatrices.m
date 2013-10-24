clc; close all; clear;
videosFolder='/host/Users/ibogun2010/datasets/Gupta/frames/';

sourceDetections='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(sourceDetections);
listDetections=listDetections(3:end);


listVideos=dir(videosFolder);
listVideos=listVideos(3:end);

% iterate through every video
% for i=1:length(listVideos)
    i=6;
    vid=strcat(videosFolder,listVideos(i).name,'/');
    
    X=generateVideoVolumeFunction(vid,1);
    
    [~,S]=RPCA(X);
    
    savefileName='/host/Users/ibogun2010/datasets/Gupta/sparse/';
    savefileName='';
    save(strcat(savefileName,listVideos(i).name,'.mat'),'S');
    
    clearvars X S;
    
% end
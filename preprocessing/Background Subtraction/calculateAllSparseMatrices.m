clc; close all; clear;
videosFolder='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames/';

sourceDetections='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(sourceDetections);
listDetections=listDetections(3:end);


listVideos=dir(videosFolder);
listVideos=listVideos(3:end);

% iterate through every video
for i=2:length(listVideos)
    
    fprintf('Current video: %d \n',i);
    
    vid=strcat(videosFolder,listVideos(i).name,'/');
    
    X=generateVideoVolumeFunction(vid,0);
    
    [L,S]=RPCA(X);
    
    savefileName='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
    %savefileName='';
    save(strcat(savefileName,listVideos(i).name,'.mat'),'S','L');
    
    clearvars X S;
    
end
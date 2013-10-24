clc; close all; clear;
videosFolder='/host/Users/ibogun2010/datasets/Gupta/frames/';

sourceDetections='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(sourceDetections);
listDetections=listDetections(3:end);


listVideos=dir(videosFolder);
listVideos=listVideos(3:end);

% iterate through every video
for i=1:length(listDetections)
    
    % example : /host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01
    % Folder with detections for current video
    detectionFilename=strcat(sourceDetections,listDetections(i).name);
    
    detections=dir(detectionFilename);
    detections=detections(3:end);
    
    % sort detections (some have xxx1 others xxx23, etc.)
    
    
    
    
    % Folder with frame for current video
    currentVideo=strcat(videosFolder,listVideos(i).name,'/');
    
    
    for j=1:length(detections)
        shortName=detections(j).name;
        digitStr=shortName(isstrprop(shortName,'digit'));
        if (length(digitStr)==2)
            digitStr=strcat('0',digitStr);
            file=(strcat(detectionFilename,'/',detections(j).name));
            newFile=strcat(detectionFilename,'/','BB_f',digitStr,'.mat');
            movefile(file,newFile);
        end
        
        
        
    end
    
end
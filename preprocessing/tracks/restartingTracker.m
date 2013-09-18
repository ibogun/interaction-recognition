videosFolder='/host/Users/ibogun2010/datasets/Gupta/frames/';

sourceDetections='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(sourceDetections);
listDetections=listDetections(3:end);


listVideos=dir(videosFolder);
listVideos=listVideos(3:end);

% iterate through every video
i=1;

% Folder with frame for current video
currentVideo=strcat(videosFolder,listVideos(i).name,'/');

% example : /host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01
% Folder with detections for current video
detectionFilename=strcat(sourceDetections,listDetections(i).name);

detections=dir(detectionFilename);
detections=detections(3:end);

% sort detections (some have xxx1 others xxx23, etc.)
detections=sortDetections(detections);

detectionFrom=load(strcat(detectionFilename,'/',detections(1).name));

% Detection data structure
detectionFrom=detectionFrom.BB;
detectionFrom=round(detectionFrom(:,1:4));
% find out what this data structure represents?


% variable to denote number of frames
[nFrames,~]=size(detections);


[bb,conf] = wrapperTLD( currentVideo,detectionFrom(1,:),1:5,1);
pause;
close;
initialBB=round(bb(:,5));
[bb,conf] = wrapperTLD( currentVideo,initialBB,5:10,1);

pause;
close;
initialBB=round(bb(:,5));
[bb,conf] = wrapperTLD( currentVideo,initialBB,10:15,1);

pause;
close;
initialBB=round(bb(:,5));
[bb,conf] = wrapperTLD( currentVideo,initialBB,15:20,1);

pause;
close;
initialBB=round(bb(:,5));
[bb,conf] = wrapperTLD( currentVideo,initialBB,20:25,1);

pause;
close;
initialBB=round(bb(:,5));
[bb,conf] = wrapperTLD( currentVideo,initialBB,25:30,1);
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
detectionFrom=round(detectionFrom(:,1:4));
% find out what this data structure represents?


% variable to denote number of frames
[nFrames,~]=size(detections);


[bb,conf] = wrapperTLD( currentVideo,detectionFrom(1,:),1:nFrames,1);
close;
%%

% Only one detection per frame
trackCounter=1;

show=0;


% Doesn't work because of the order of detecions
for j=1:nFrames
    %break;
    display(j);
    % read in detections
    detectionFrom=load(strcat(detectionFilename,'/',detections(j).name));
    
    % Detection data structure
    detectionFrom=detectionFrom.BB;
    detectionFrom=round(detectionFrom(:,1:4));
    
    
    % for every detection
    % for k=1:size(detectionFrom,1)
    k=1;
    
    if j==1
        % case 1 - first frame
        [bb,conf] = wrapperTLD( currentVideo,detectionFrom(k,:),1:nFrames,show);
        
    elseif j==nFrames
        % case 2 - last frame
        [bb,conf] = wrapperTLD( currentVideo,detectionFrom(k,:),nFrames:-1:1,show);
        conf=conf(end:-1:1);
        bb=bb(:,end:-1:1);
    else
        % both
        [bbF,confF] = wrapperTLD( currentVideo,detectionFrom(k,:),j:nFrames,show);
        [bbB,confB] = wrapperTLD( currentVideo,detectionFrom(k,:),j:-1:1,show);
        
        confB=confB(end:-1:1);
        bbB=bbB(:,end:-1:1);
        
        % merge two
        bb=[bbB,bbF];
        conf=[confB,confF];
    end
    
    track(k,j).bb=bb;
    track(k,j).conf=conf;
    trackCounter=trackCounter+1;
    
    %end
end


























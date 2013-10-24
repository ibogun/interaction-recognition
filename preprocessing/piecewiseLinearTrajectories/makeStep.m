function [ frame, detection,dGroup] = makeStep( frame, detection,dGroup,...
    currentD,d,nAhead,r)
%MAKESTEP Summary of this function goes here
%   Detailed explanation goes here


% get all detections in the frame
dInFrame=d{frame};

% get detection #1
startDetection=dInFrame(detection,:);

if (nargin<7)
    r=15;
end

if (nargin<6)
    % how many frames ahead
    nAhead=5;
end

% allocate memory for the line
line=zeros(nAhead+1,2);
firstPoint=findCenter(startDetection);
line(1,:)=firstPoint;

% memory for the best matches of upcoming detections
detIdx=zeros(nAhead,1);

% loop and find closest detection in each of upcoming frames in the
% neighborhood
for nextFrame=frame+1:frame+nAhead
    [next, nextIdx]=findClosestDetection(startDetection,d{nextFrame},r*(nextFrame-frame));
    
    if (~isempty(next))
        line(nextFrame-frame+1,:)=findCenter(next);
        detIdx(nextFrame-frame,1)=nextIdx;
    end
    
end

if (all(detIdx==0))
    
   % bad case - nothing was found.
    frame=[];
    detection=[];
    return;
   
end

% binary mask for positive detections
goodIdxMask=(line(:,1)>0);
% indices for the positive detctions
goodIdx=find(line(:,1)>0);

% outliers in the remaining part
outliers=fitLine(line(goodIdxMask,:));

%indices without outliers, without the initial detection
goodIdx=goodIdx(~outliers);

if (size(goodIdx)==1)
    
   % bad case - nothing was found.
    frame=[];
    detection=[];
    return;
   
end

% hardcoded to simplify the code
dGroup{frame,detection}=[dGroup{frame,detection},currentD];

% add same label to the detections
for i=2:length(goodIdx)
    dGroup{frame+goodIdx(i)-1, detIdx(goodIdx(i)-1)}=...
        [dGroup{frame+goodIdx(i)-1, detIdx(goodIdx(i)-1)},currentD];
end

[maxVal, idx]=max(goodIdx);
frame=frame+maxVal-1;
detection=detIdx(goodIdx(idx)-1);




end


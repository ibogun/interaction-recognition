clc;clear;close all;

dFolder='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01/';
files=dir(dFolder);
files=files(3:end);


% 10 detections in length(files) frame -> total 10*length(files)
dGroup=cell(length(files),10);

% load all detections into a matrix d
for i=1:length(files)
    
    dFileName=strcat(dFolder,files(i).name);
    
    load(dFileName);
    
    %load bounding box
    BB=BB(:,1:4);
    
    d{i}=BB;
end

clearvars BB dFileName dFolder files;
% radius - 10 pixels (search will be done within these 10 pixels)
r=15;

%% current detection group
currentD=1;

% starting point, frame #1, detection #1
frame=1;
detection=1;

for j=1:69
    for i=1:size(d{j},1)
        frame=j;
        detection=i;
        %     display(i);
        %     detection=i;
        %     display(dGroup(1:10,1:10));
        [ dGroup, currentD] = iterateTrajectoryUntilEnd( frame,detection,...
            dGroup,currentD,d);
    end
end
% while (frame<69-5)
%     [frame,detection,dGroup]=makeStep(frame,detection,dGroup,currentD,d);
%     if (isempty(frame))
%         currentD=currentD+1;
%         break;
%     end
%     %fprintf('Frame %d, detection %d \n',frame,detection);
% end
% [frame,detection,dGroup]=makeStep(frame,detection,dGroup,currentD,d);
% display(frame);
% display(detection);




























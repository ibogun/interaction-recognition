%clc;clear; close all;

videoNames='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames/';
videos=dir(videoNames);
videos=videos(3:end);


%clearvars videoNames;

for i=1:length(videos)
    fullVideoNames{i}=strcat(videoNames,videos(i).name);
end

% find the bounding box of the largest energy in all frames

w=20;
h=20;

load interpolatedFullDataInStruct;


% for id=1:54
%     fprintf('Current video #%d \n',id);
%     currentSparseName=strcat(sparseFiles,spars


vid=5;

files=dir(fullVideoNames{vid});
files=files(3:end);

traj=trajectory(vid).trajectory;
traj=traj*2;

for i=1:size(traj,1)
    
    
    x=traj(i,1);
    y=traj(i,2);
    imshow(strcat(fullVideoNames{vid},'/',files(i).name));
    hold on;
    plot(y,x,'b*');
    
    pause(0.04);
    
    
end
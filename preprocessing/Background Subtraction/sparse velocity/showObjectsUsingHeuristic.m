%clc;clear;
close all;

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




%%
% for id=1:54
%     fprintf('Current video #%d \n',id);
%     currentSparseName=strcat(sparseFiles,spars


r=30;

figure

n=480;
m=640;

for vid=1:54
    
    subplot(6,9,vid);
    
    files=dir(fullVideoNames{vid});
    files=files(3:end);
    
   
    
    traj=trajectory(vid).trajectory;
    traj=traj*2;
    
    %[~,idx]=max(traj(:,1));
    
    idx=data(vid).tInteractionStart+7;
    
    [~,idx]=max(traj(:,1));
    
    y=traj(idx,1);
    x=traj(idx,2);
    
    minX=max(x-r,1);
    maxX=min([x+r],n);
    
    minY=max([y-r],1);
    maxY=min([y+r],m);
    
    I=imread(strcat(fullVideoNames{vid},'/',files(idx).name));
    %     imshow(strcat(fullVideoNames{vid},'/',files(i).name));
    %     hold on;
    %
    %
    %
    %     plot(x,y,'b*');
    %
    %     pause(0.04);
    
    
    patch=I(minY:maxY,minX:maxX,:);
    imshow(patch);
    
end
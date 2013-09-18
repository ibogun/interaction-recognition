function [ ] = visualizeTrack( currentVideo, track)
%VISUALIZETRACK Summary of this function goes here
%   Detailed explanation goes here

images=dir(currentVideo);
images=images(3:end);
bb=[track.bb;track.conf];

for i=1:length(images)
    imageName=strcat(currentVideo,images(i).name);
%     I=imread(imageName);
%     I=rgb2gray(I);
    imshow(imageName);
    hold on;
    drawBB(bb(:,i));
    
    pause(0.05);
    
end

close;
% draw a bounding box

end


function []=drawBB(d)
if (any(isnan(d)))
    return;
end
line([d(1),d(3)],[d(2),d(2)],'LineWidth',2);
hold on;

line([d(1),d(1)],[d(2),d(4)],'LineWidth',2);
hold on;


line([d(1),d(3)],[d(4),d(4)],'LineWidth',2);
hold on;

line([d(3),d(3)],[d(2),d(4)],'LineWidth',2);
hold on;

end
function [  ] = showDetection( image,detections,k )
%SHOWDETECTION Summary of this function goes here
%   Detailed explanation goes here
close all;
n=size(detections,1);
d=detections;

if nargin<3
    k=size(detections,1);
end

imshow(image);

hold on

for i=1:k
    %plot([d(i,2),d(i,1)],[d(i,4),d(i,1)]);
    %plot([d(i,2),d(i,4)],[d(i,1),d(i,1)]);
    
    line([d(i,1),d(i,3)],[d(i,2),d(i,2)],'LineWidth',2);
    hold on;
    
    line([d(i,1),d(i,1)],[d(i,2),d(i,4)],'LineWidth',2);
    hold on;
    
    
    line([d(i,1),d(i,3)],[d(i,4),d(i,4)],'LineWidth',2);
    hold on;
    
    line([d(i,3),d(i,3)],[d(i,2),d(i,4)],'LineWidth',2);
    hold on;
    
%     plot([d(i,2),d(i,1)],[d(i,2),d(i,3)]);
%     hold on;
%     
%     plot([d(i,4),d(i,1)],[d(i,4),d(i,3)]);
%     hold on;
%     
%     plot([d(i,2),d(i,1)],[d(i,4),d(i,1)]);
%     hold on;
end

end


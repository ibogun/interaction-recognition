function [ vid ] = getImageData( id,videoNames )
%GETIMAGEDATA Summary of this function goes here
%   Detailed explanation goes here

if nargin<2
    videoNames='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames/';
end
videos=dir(videoNames);
videos=videos(3:end);


%clearvars videoNames;

for i=1:length(videos)
    fullVideoNames{i}=strcat(videoNames,videos(i).name);
end



images=dir(fullVideoNames{id});
images=images(3:end);

n=length(images);

for j=1:n
    vid{j}=imread(strcat(fullVideoNames{id},'/',images(j).name));
end




end


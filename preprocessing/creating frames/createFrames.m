function [  ] = createFrames( videoFolderSource, destination )
%CREATEFRAMES Create frames at 25 frames per second for every video
%
%   Input:
%
%       videoFolderSource   -           folder with videos
%       destination         -           destination folder for the frames
%
%
%
%   Ivan Bogun
%   July 9, 2013

%videoFolderSource='/host/Users/ibogun2010/datasets/Gupta/video';

source=destination;


% create folder 'frames'
mkdir(source,'frames');

frameFolder=strcat(source,'frames');


list=dir(videoFolderSource);
list=list(3:end);


for i=1:length(list)
    
    % get video name
    videoFullName=strcat(videoFolderSource,'/',list(i).name);
    
    a=regexp(list(i).name,'\.','split');
    
    videoName=a{1};
    
    % create directory
    mkdir(frameFolder,videoName);
    
    fullFrameFolder=strcat(frameFolder,'/',videoName,'/','%3d.ppm');
    
    CML=horzcat('ffmpeg -i ',videoFullName,' -f image2 ',fullFrameFolder);
    
    dos(CML);
    
end




end


clc; close all; clear;
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

files=dir(currentVideo);
files=files(3:end);

X=zeros(480*640/4,length(files));

for j=1:length(files)
   imageFilename=strcat(currentVideo,files(j).name);
   
   I=double(rgb2gray(imread(imageFilename)));
   I=imresize(I,0.5);
   X(:,j)=reshape(I,[],1);
end

clearvars -EXCEPT X;

%% Run RPCA

%[A, E, ~]=proximal_gradient_rpca(D',0.15);
%[A, iterations, spr]=inexact_alm_mc(D,0.15);
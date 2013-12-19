function [ X ] = generateVideoVolumeFunction( currentVideo,inv)
%GENERATEVIDEOVOLUMEFUNCTION Summary of this function goes here
%   Detailed explanation goes here

if (nargin<2)
    inv=0;
end
    
% Folder with frame for current video


files=dir(currentVideo);
files=files(3:end);

X=zeros(480*640/4,length(files));

for j=1:length(files)
   imageFilename=strcat(currentVideo,files(j).name);
   
   im=rgb2gray(imread(imageFilename));
   
   if (inv)
       im=imcomplement(im);
   end
   
   I=double(im);
   I=imresize(I,0.5);
   X(:,j)=reshape(I,[],1);
end


end


clc;clear; close all;

sparseFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
sparseNames=dir(sparseFiles);
sparseNames=sparseNames(3:end);

imageFolder='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames';
videos=dir(imageFolder);
videos=videos(3:end);

% get images

for i=1:length(videos)
    vidName=strcat(imageFolder,'/',videos(i).name);
end

% find the bounding box of the largest energy in all frames

n=480/2;
m=640/2;
H = fspecial('disk',10);


for id=1:1
    fprintf('Current video #%d \n',id);
    currentSparseName=strcat(sparseFiles,sparseNames(id).name);
    S=load(currentSparseName);
    S1=S.S;
    
    T=size(S1,2);
    
    s=zeros(n,m,T);
    
    for t=1:T
        
        im=reshape(S1(:,t),n,m);
        im=imfilter(im,H,'replicate');
        s(:,:,t)=abs(im);
    end
    
end

clearvars -except s;
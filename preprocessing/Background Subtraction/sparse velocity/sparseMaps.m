clc;clear; close all;


load trajectoriesCalculated;

% update the path to the data
sparseFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
sparseNames=dir(sparseFiles);
sparseNames=sparseNames(3:end);

w=20;
h=20;

n=240;
m=320;

r=25;

totalDistanceError=0;

% choose video number
id=35;

fprintf('Current video #%d \n',id);
currentSparseName=strcat(sparseFiles,sparseNames(id).name);
S=load(currentSparseName);
S1=S.S;

%clearvars -except S1 data trajectory id;

H = fspecial('disk',10);
T=size(S1,2);
%
S1=abs(S1);



% The following will show a movie of the frames
% frame count
for i=1:T
    im=S1(:,i);
    im=reshape(im,240,320);
    %smoothing, if neccessary
    im=imfilter(im,H,'replicate');
    imagesc(im);
    pause(0.3);
end


clc;clear; close all;

sparseFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
sparseNames=dir(sparseFiles);
sparseNames=sparseNames(3:end);


%load c20;

load trajectoriesCalculated;

% find the bounding box of the largest energy in all frames

w=20;
h=20;


id=19;

%fprintf('Current video #%d \n',id);
currentSparseName=strcat(sparseFiles,sparseNames(id).name);
S=load(currentSparseName);
S1=S.S;
clearvars -except S1 ;

n=480;
m=640;


for j=2:size(S1,2)
    im1=reshape(S1(:,j-1),n/2,m/2);
    im2=reshape(S1(:,j),n/2,m/2);
    
    I(1).im=im1;
    I(2).im=im2;
    I(3).im=im2-im1;
    
    I(1).title='first';
    I(2).title='second';
    I(3).title='difference';
    for i=1:3
        subplot(1,3,i);
        colormap('cool');
        h=imagesc(I(i).im);
        
        title(I(i).title);
    end
    
    pause(1);
    %close all;
end
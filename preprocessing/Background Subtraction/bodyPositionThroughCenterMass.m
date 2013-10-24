clc;close all;clear;

sparseFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
sparseNames=dir(sparseFiles);
sparseNames=sparseNames(3:end);




id=11;

currentSparseName=strcat(sparseFiles,sparseNames(id).name);
S=load(currentSparseName);
S1=S.S;
clearvars -except S1 ;



n=480;
m=640;
frame=1;

H = fspecial('disk',10);

for frame=1:size(S1,2)
    im=S1(:,frame);
    %im(abs(im)<2)=0;
    im=reshape(im,n/2,m/2);
    im=abs(im);
    
    im = imfilter(im,H,'replicate');

    
    r=[0;0];
    for i=1:n/2
        for j=1:m/2
            r=r+[i;j]*im(i,j);
        end
    end
    
    r=r/(sum(im(:)));
    
    imagesc(im);
    hold on;
    plot(r(2),r(1),'s','Color','red');
    
    pause(0.4);
end
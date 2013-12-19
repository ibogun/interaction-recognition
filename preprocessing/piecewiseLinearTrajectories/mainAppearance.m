dFolder='/host/Users/ibogun2010/datasets/Gupta/frames/c01/';
files=dir(dFolder);
files=files(3:end);

load d_dGroup;
load trajectories;

clearvars ans center data det f  l label labels;

n=length(files);

for i=1:length(files)
    imNames{i}=strcat(dFolder,files(i).name); %#ok<SAGROW>
end
im=imread(imNames{1});
I=im;

% from 3D to 2D
im=reshape(im,[],1,3);
im=squeeze(double(im));


rgb2o1=@(x) (x(:,1)-x(:,2))/2;
rgb2o2=@(x) (2*(x(:,1)-x(:,2)-x(:,3))/4);

o1=rgb2o1(im);
o2=rgb2o2(im);

% # of elements in the bins
bins=linspace(-255/2,255/2,16);

[h1,ind]=histc(o1,bins);
[h2,ind]=histc(o2,bins);

% rg color space
% rgb2r=@(x) (x(:,1)./(x(:,1)+x(:,2)+x(:,3)));
% rgb2g=@(x) (x(:,2)./(x(:,1)+x(:,2)+x(:,3)));
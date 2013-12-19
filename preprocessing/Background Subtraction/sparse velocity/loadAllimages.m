function [ vidVolume ] = loadAllimages( path,n,m)
%LOADALLIMAGES Summary of this function goes here
%   Detailed explanation goes here


files=dir(path);
files=files(3:end);

T=length(files);



for i=1:T
    filenames{i}=strcat(path,'/',files(i).name);
end

vidVolume=zeros(n,m,3,T);

for i=1:T
   im=imread(filenames{i});
   im=rgb2hsv(im);
   vidVolume(:,:,:,i)=im;
end


end


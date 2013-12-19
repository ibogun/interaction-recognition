function [ res ] = computeImageDifference( im1,im2,method )
%UNTITLED Find difference in the images in a specific colorspace
%   Calculate image different, but at first transform RGB values for each
%   image into 'method' colorspace.
%
%   Input:
%       im1                 -           image one
%       im2                 -           image two, should be of the same
%           size as im1
%       method              -           colorspace in which images should
%           be compared
%
%   Output:
%
%   res                     -           image difference 
%
% Note: available colorspace:
% 'YPbPr','YCbCr','JPEG-YCbCr','YUV',YIQ','YDbDr','HSV','HSL','HSI','XYZ',
% 'Lab','Luv','LCH','CAT02 LMS'.
%
% Colorspace conversion by Pascal Getreuer license is in the 'colorspace'
% folder.
%
% author: Ivan Bogun Pascal Getreuer
% date: Nov. 20, 2013
%

[n,m,k]=size(im1);

im1=double(im1)/255;
im2=double(im2)/255;

if nargin==3
    im1=colorspace([method,'<-RGB'],im1);
    im2=colorspace([method,'<-RGB'],im2);
end

I=(im1)-(im2);

I=reshape(I,[],3);

a1=I(:,1);
a2=I(:,2);
a3=I(:,3);

res=arrayfun(@sqrt,a1.^2+a2.^2+a3.^2);

maxRes=max(res(:));

res=reshape(res,n,m)/maxRes;



end


function [ doublets ] = getDoubletsFromPatch( patch )
%GETDOUBLETSFROMPATCH Summary of this function goes here
%   Detailed explanation goes here

patch=rgb2gray(patch);
d1=getDoublets(patch);
d2=getDoublets(patch');
doublets=[d1;d2];



end



function doublets=getDoublets(patch)


[n,m,~]=size(patch);

d=5;



nRows=floor(n/d);
nCols=floor(m/d);

%doublets=zeros(d,nRows*nCols);

c=1;

for i=1:nRows-1
    for j=1:nCols
        
        v=patch((i-1)*d+1:(i+1)*d,(j-1)*d+1:j*d);
        v=v(:);
        %v=hist(double(v));
        doublets(c,:)=v';
        c=c+1;
    end
end


end
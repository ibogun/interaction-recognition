function [ edges ] = getEdgesFromPatch( patch )
%GETEDGESFROMPATCH Summary of this function goes here
%   Detailed explanation goes here

patch=rgb2gray(patch);
edges=getEdges(patch);
end



function edges=getEdges(patch)

patch=canny(patch);
[n,m,~]=size(patch);

d=5;

nRows=floor(n/d);
nCols=floor(m/d);

%doublets=zeros(d,nRows*nCols);

c=1;

for i=1:nRows
    for j=1:nCols
        
        v=patch((i-1)*d+1:(i)*d,(j-1)*d+1:j*d);
        v=v(:);
        %v=hist(double(v));
        edges(c,:)=v';
        c=c+1;
    end
end


end



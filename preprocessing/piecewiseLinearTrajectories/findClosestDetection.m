function [ result, idx ] = findClosestDetection(...
    currentDetection,nextDetections,rad)
%FINDCLOSESTDETECTION Summary of this function goes here
%   Detailed explanation goes here

c1=findCenter(currentDetection);

l=size(nextDetections,1);

r=zeros(l,1);


%find the closest
for i=1:l
    c2=findCenter(nextDetections(i,:));
    
    
    %threshold if it is further than r
    dist=norm(c1-c2);
        
    r(i,1)=dist;
    
end

[~,idx]=min(r);

if r(idx,1)>rad
    result=[];
    idx=[];
else
    result=nextDetections(idx,:);
end

end


function [ K ] = getDistanceKernel( trajectoriesArray )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here


n=size(trajectoriesArray,2);

distArray=zeros(n,1);

for i=1:n
   
    distArray(i,1)=calculateDistance(trajectoriesArray{2,i});
    
end


kernel=getKernel('gaussian',5);

K=zeros(n,n);

for i=1:n
    for j=1:n
        
        K(i,j)=kernel(distArray(i,1),distArray(j,1));
    
    end
end


end




function distance=calculateDistance(velocity)

velocity=velocity(:,1).^2+velocity(:,2).^2;

velocity=arrayfun(@sqrt,velocity);

distance=sum(velocity);


end


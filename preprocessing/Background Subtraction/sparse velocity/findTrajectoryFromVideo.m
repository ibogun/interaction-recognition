function [ bestTrajectory,maxTrajectoryEnergy ] = findTrajectoryFromVideo(S1,H,n,m,r,groundTruthTrajectory,name)
%FINDTRAJECTORYFROMVIDEO Summary of this function goes here
%   Detailed explanation goes here



%I = imfilter(I,H,'replicate');

T=size(S1,2);

%S=zeros(n*m,T);
% normalize with a gaussian and find the maximum

maxIndices=zeros(T,2);
traj=cell(T,1);

for i=1:T
    im=S1(:,i);
    im=reshape(im,n,m);
    im=imfilter(im,H,'replicate');
    S1(:,i)=abs(reshape(im,n*m,1));
    
    
    % should it be max( abs(im(:))) ???
    [~,idx]=max(im(:));
    [x,y]=ind2sub([n,m],idx);
    maxIndices(i,:)=[x,y];
    
end


for t=1:T
    %S=abs(reshape(S,n*m,T));
    idx=maxIndices(t,:);
    b=track(S1,n,m,r,idx(1),idx(2),t);
    traj{t}=b;
    
end


if (nargin==7)
    save(strcat('data/',name),'traj');
end



[ bestTrajectory,maxTrajectoryEnergy ] = chooseBestTrajectory( traj,groundTruthTrajectory );



end


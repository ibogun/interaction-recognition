function [ count ] = createBins( trajectories,n,m )
%CREATEBINS Summary of this function goes here
%   Detailed explanation goes here

T=size(trajectories,2);

count=zeros(n/10,m/10,T);

for t=1:T
    traj=trajectories{t};
    
    for frame=1:T
        
        posX=traj(frame,1);
        posY=traj(frame,2);
        
        posX=ceil(posX/10);
        posY=ceil(posY/10);
        
        count(posX,posY,frame)=count(posX,posY,frame)+1;
    end
    
end

end


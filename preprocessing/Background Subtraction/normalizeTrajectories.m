function [ trajectoriesArray ] = normalizeTrajectories( trajectory,bodyReference )
%NORMALIZETRAJECTORIES Summary of this function goes here
%   Detailed explanation goes here

% swap axes of the reference and divide by 2


bodyReference=bodyReference/2;


n=length(trajectory);

trajectoriesArray=cell(2,n);
%trajectory=localizeInteraction(trajectory);
for v=1:n
    
    meanPos=bodyReference(v,:);
    
    
    % vertical
    y=[trajectory(v).trajectory.i];
    
    gaussFilter = gausswin(5);
    gaussFilter = gaussFilter / sum(gaussFilter); 
    
   
    % horizontal
    x=[trajectory(v).trajectory.j];
    
    %[y x] is correct
    x=abs(x-meanPos(1));
    y=y-meanPos(2);
    
%     y=conv(y,gaussFilter,'same');
%     x=conv(x,gaussFilter,'same'); 
    
    
    traj=[x;y];
    
    maxNorm=max(sqrt(sum(abs(traj).^2,1)));
    traj=traj/maxNorm;
    
    traj=traj';
    vel=traj(2:end,:)-traj(1:end-1,:);
    
    trajectoriesArray{1,v}=traj;
    trajectoriesArray{2,v}=vel;
end

end




function [ trajectory]= localizeInteraction(trajectory)


threshold=0.3;

n=length(trajectory);

for z=1:n
   t=trajectory(z).bestT;
   
   x=[trajectory(z).trajectory.i];
   y=[trajectory(z).trajectory.j];
   
   energy=[trajectory(z).trajectory.sparseEnergy];
   maxEnergy=energy(t);
   
   t1=find(energy<maxEnergy*threshold,1,'first');
   t2=find(energy<maxEnergy*threshold,1,'last');
   
   traj=trajectory(z).trajectory;
   trajectory(z).trajectory=traj(t1:t2);
end


end

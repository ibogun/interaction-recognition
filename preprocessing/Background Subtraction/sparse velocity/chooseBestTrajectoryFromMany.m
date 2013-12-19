%clc; clear; close all;

%load allTrajectoriesOnlyMaxSparseEnergyWithV;
%load allTrajectoriesr=25s1=9s2=12s3=6;
load latestTrajectories;
load groundTruth;

T=size(allTraj,2);


fromAllToOneTrajectoryIndex=zeros(T,1);

for t=1:T
   trajectoryClass=allTraj{1,t};
   
   nTrajectories=size(trajectoryClass,2);
   
   trackMeasure=zeros(nTrajectories,1);
   
   energy=zeros(nTrajectories,1);
   height=zeros(nTrajectories,1);
   
   for traj=1:nTrajectories
       
       tjct=trajectoryClass{traj};
       
       len=size(tjct,1);

       x=tjct(1:end-1,1)-tjct(2:end,1);
       y=tjct(1:end-1,2)-tjct(2:end,2);
       ymin=min(tjct(:,1));
       ymax=max(tjct(:,1));
       
       energy(traj)=sum(tjct(:,3));
       
       height(traj)=ymax-ymin;
       
       distance= sum(sqrt(x.^2+y.^2));
       trackMeasure(traj,1)=distance;
   end
   
   energy=energy/max(energy);
   distance=distance/max(distance);
   height=height/max(height);
   
   [~,idx]=max(energy);
   fprintf('Current video: %d, best trajectory index: %d \n',t,idx);
   fromAllToOneTrajectoryIndex(t)=idx;
   trajectory(t).trajectory=trajectoryClass{idx};
   
end
%save('fromAllToOneTrajectoryIndex','fromAllToOneTrajectoryIndex');
checkTrajectoryQuality;
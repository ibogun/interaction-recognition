function [ bestTrajectory,idx ] = chooseBestTrajectory( trajectories)
%CHOOSEBESTTRAJECTORY Summary of this function goes here
%   Detailed explanation goes here



%% try #1 best trajectory is the one with the largest energy
% T=length(trajectories);
% energies=zeros(T,1);
%
% for i=1:T
%    b=trajectories{i};
%    energies(i)=sum(b(:,3));
% end
% [maxTrajectoryEnergy,idx]=max(energies);
%
% bestTrajectory=trajectories{idx};

% Result: 41.6 average pixel distance error


%% try #2: best trajectory as the trajectory which travelled the most
% T=length(trajectories);
% energies=zeros(T,1);
%
% for i=1:T
%    b=trajectories{i};
%    x=[b(:).i];
%    y=[b(:).j];
%
%    distance=[x(2:end)-x(1:end-1);y(2:end)-y(1:end-1)];
%
%    energies(i)=norm(distance);
% end
% [maxTrajectoryEnergy,idx]=max(energies);
%
% bestTrajectory=trajectories{idx};


%% testing: choose trajectory as the closest to ground truth


% T=length(trajectories);
% % append with zeros because annotations start from the frame #3
% t_a=[zeros(2);trajAnnotated.trajectoryObject];
% 
% tStart=trajAnnotated.tInteractionStart;
% tStop=trajAnnotated.tInteractionStop;
% t_a=t_a(tStart:tStop,:);
% 
% idx=0;
% bestMatch=100000;
% for i=1:T
%     b=trajectories{i};
%     
%     clearvars t_c;
%     t_calc=b;
% 
% %    bestT=trajectory(v).bestT;
% 
% 
% 
%     t_c(:,2)=t_calc(:,1);
%     t_c(:,1)=t_calc(:,2);
%     t_c=t_c*2;
%     
%     t_c=t_c(tStart:tStop,:);
%     
%     
%     if (norm(t_c-t_a)<=bestMatch)
%        idx=i;
%        bestMatch=norm(t_c-t_a);
%     end
%     
% end
% 
% bestTrajectory=trajectories{idx};

%% try #4: best trajectory as the one which travelled the most times it's 
% energy


%% try #2: best trajectory as the trajectory which travelled the most
T=length(trajectories);
energies=zeros(T,1);

for i=1:T
   b=trajectories{i};
   x=b(:,1);
   y=b(:,2);

   distance=[x(2:end)-x(1:end-1),y(2:end)-y(1:end-1)];
  
   energies(i)=sum(b(:,3))*norm(distance);
end
[maxTrajectoryEnergy,idx]=max(energies);

bestTrajectory=trajectories{idx};

end


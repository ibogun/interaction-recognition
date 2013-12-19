%clc; clear; close all;

load('interpolatedFullDataInStruct');
load('groundTruth');
load Background' Subtraction'/bodyReferenceThroughCenterMass;
%load Background' Subtraction'/peaks/traj_maxEnergy.mat;
n=length(data);

withVelocities=1;

if withVelocities==1
    trajectoriesArray=cell(2,n);
else
    trajectoriesArray=cell(1,n);
end
% 0 - annotated, 1 - calculated, 2 - from grasp to putback
isLocalizationEstimated=3;

if isLocalizationEstimated==2
    groundTruthExtended=zeros(n,1);
else
    nAdded=0;
end
nAdded=0;

bodyReference=bsxfun(@minus,bodyReference,[0,140]);
for i=1:n
    clearvars t_calc t_c;
    l=data(i).trajectoryLeftHand;
    r=data(i).trajectoryRightHand;
    o=data(i).trajectoryObject;
    h=data(i).trajectoryHead;
    
    t_calc=trajectory(i).trajectory;
    
        
    t_c(:,2)=t_calc(:,1);
    t_c(:,1)=t_calc(:,2);
    t_c=t_c*2;
    
    
    
    
    % normalization with respect to the head;
    [trajectorySize,~]=size(l);
    
    for j=1:trajectorySize
        
        l(j,:)=l(j,:)-h(j,:);
        r(j,:)=r(j,:)-h(j,:);
        o(j,:)=o(j,:)-h(j,:);
    end
    %t_c(1:2,:)=[];
    
    if (size(t_c,1)>size(h,1))
       t_c(end,:)=[]; 
    end
    
    if (size(t_c,1)>size(h,1))
       t_c(end,:)=[]; 
    end
    
   % for 
   
    
    hand=bsxfun(@minus,t_c,bodyReference(i,:));
    if (isLocalizationEstimated==1)
        % estimated interaction start/stop
        [tStart,tEnd]=localizeInteraction(data(i));
    elseif (isLocalizationEstimated==0)
        % 'ground truth' interaction start/stop
        tStart=data(i).tInteractionStart;
        tEnd=data(i).tInteractionStop;
    elseif (isLocalizationEstimated==2)
        tStart=data(i).tGrasp;
        tEnd=data(i).tPutBack;
        if (tEnd>length(l))
            tEnd=length(l);
        end
        
        for kk=0:nAdded
            groundTruthExtended(i*(1+nAdded)-nAdded+kk)=groundTruth(i);
        end
    end
    
    clearvars t_c;
    
    distance=zeros(trajectorySize,1);
    
    %hand=findMostCorrelated(l,r,o);
    
    %hand=smooth(hand,19);
    
    for j=1:trajectorySize
        distance(j)=norm(hand(j,:));
    end
    
    maxDistance=max(distance);
    hand=hand/maxDistance;
    
    traj=hand;
    
    len=length(traj);
    
%    traj=traj(tStart:tEnd,:);
    
    [hand,invHand]=preprocessTrajectory(traj);
    trajectoriesArray{1,i}=[hand ];
    if withVelocities==1
        trajectoriesArray{2,i}=invHand;
    end
    
end

clearvars -except trajectoriesArray groundTruth;

% if (isLocalizationEstimated==2)
%     groundTruth=groundTruthExtended;
% end


%noiseAndOutlyingEntriesSSCproblem;
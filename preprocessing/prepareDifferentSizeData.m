clc; clear; close all;

load('interpolatedFullDataInStruct');
load('groundTruth');

n=length(data);

withVelocities=1;

if withVelocities==1
    trajectoriesArray=cell(2,n);
else
    trajectoriesArray=cell(1,n);
end
% 0 - annotated, 1 - calculated, 2 - from grasp to putback
isLocalizationEstimated=0;

if isLocalizationEstimated==2
    groundTruthExtended=zeros(n,1);
else
    nAdded=0;
end
nAdded=0;


for i=1:n
    l=data(i).trajectoryLeftHand;
    r=data(i).trajectoryRightHand;
    o=data(i).trajectoryObject;
    h=data(i).trajectoryHead;
    
    % normalization with respect to the head;
    [trajectorySize,~]=size(l);
    
    for j=1:trajectorySize
        l(j,:)=l(j,:)-h(j,:);
        r(j,:)=r(j,:)-h(j,:);
        o(j,:)=o(j,:)-h(j,:);
    end
    
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
    
    
    
    distance=zeros(trajectorySize,1);
    
    hand=findMostCorrelated(l,r,o);
    
    hand=smooth(hand,19);
    
    for j=1:trajectorySize
        distance(j)=norm(hand(j,:));
    end
    
    maxDistance=max(distance);
    hand=hand/maxDistance;
    
    traj=hand;
    
    len=length(traj);
    
    traj=traj(tStart:tEnd,:);
    
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
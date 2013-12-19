clc; clear; close all;

load('interpolatedFullDataInStruct');
load('groundTruth');

n=length(data);

tNewMax=50;
tNewMin=3;

percentage=[1];
nAdded=length(percentage);
nAdded=0;



% 0 - annotated, 1 - calculated, 2 - from grasp to putback
isLocalizationEstimated=1;

if isLocalizationEstimated==2
    groundTruthExtended=zeros(n*(1+nAdded),1);
else
    nAdded=0;
end

dataMatrix=zeros(n*(1+nAdded),2*(tNewMax-tNewMin+1));
velocityMatrix=zeros(n*(1+nAdded),2*(tNewMax-tNewMin));

for i=1:n
    l=data(i).trajectoryLeftHand;
    r=data(i).trajectoryRightHand;
    o=data(i).trajectoryObject;
    h=data(i).trajectoryHead;
    
    % normalization;
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
    
    [hand,invHand]=preprocessTrajectory(traj,tNewMin,tNewMax,tStart,tEnd);
    
    
    
    %     hand=resample1(hand,tNewMin,tNewMax,tStart,tEnd);
    %
    %
    %
    %     % NORMALIZATION VIA absolute value
    %     hand(:,2)=abs(hand(:,2));
    %
    %     velocity_x=diff(hand(:,1));
    %     velocity_y=diff(hand(:,2));
    %
    %     invHand=[velocity_x velocity_y];
    %
    %     hand=hand(:)';
    %     invHand=invHand(:)';
    
    dataMatrix(i*(1+nAdded)-nAdded,:)=hand;
    velocityMatrix(i*(1+nAdded)-nAdded,:)=invHand;
    
    for kk=1:nAdded
        trajLength=tEnd-tStart;
        [hand,invHand]=preprocessTrajectory(traj,tNewMin,tNewMax,tStart,...
            tStart+round(trajLength*percentage(kk)));
        dataMatrix(i*(1+nAdded)-nAdded+kk,:)=hand;
        velocityMatrix(i*(1+nAdded)-nAdded+kk,:)=invHand;
    end
    
    
end
dataMatrix=[dataMatrix  velocityMatrix];

% if (isLocalizationEstimated==2)
%     groundTruth=groundTruthExtended;
% end

dataMatrix=dataMatrix';
%[a,c,b]=SSC(dataMatrix,groundTruth,6,0,0.001);
%noiseAndOutlyingEntriesSSCproblem;
clc;clear; close all;

mex trackFast.cpp;
load trajectoriesCalculated;
load interpolatedFullDataInStruct;
load groundTruth;

sparseFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
sparseNames=dir(sparseFiles);
sparseNames=sparseNames(3:end);


imageFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames';
vidNames=dir(imageFiles);
vidNames=vidNames(3:end);



for i=1:length(vidNames)
   fullVidNames{i}=strcat(imageFiles,'/',vidNames(i).name); 
end

w=20;
h=20;

n=240;
m=320;

r=30;

totalDistanceError=0;
fid = fopen('PlusNegMaxSparseAndVelocity1.txt','w');

%fprintf(fid,'current radius value, r %d\n',r);

for id=1:54
    
%     if (groundTruth(id)==5)
%         continue;
%     end
    
    fprintf('Current video #%d \n',id);
    currentSparseName=strcat(sparseFiles,sparseNames(id).name);
    S=load(currentSparseName);
    S1=S.S;
    
    %clearvars -except S1 data trajectory id;
    
    H = fspecial('disk',10);
    T=size(S1,2);
    %S1(S1<0)=0;
    S1=abs(S1);
    
    for i=1:T
        im=S1(:,i);
        im=reshape(im,240,320);
        im=imfilter(im,H,'replicate');
        S1(:,i)=reshape(im,[],1);
        
        
        [~,idx]=max(im(:));
        [x,y]=ind2sub([n,m],idx);
        maxIndices(i,:)=[x,y];
    end
    
    
    
    [val,idx]=max(S1(:));
    [a1,bestT]=ind2sub([size(S1,1) size(S1,2)],idx);
    
    [bestI,bestJ]=ind2sub([240,320],a1);
    
    
       
    % check trajectories quality
    
    trajAnnotated=data(id);
    
    % append with zeros because annotations start from the frame #3
    t_a=[zeros(2);trajAnnotated.trajectoryObject];
    
    tStart=trajAnnotated.tInteractionStart;
    tStop=trajAnnotated.tInteractionStop;
    t_a=t_a(tStart:tStop,:);
    
    
    frameTrajectoryError=zeros(T,1);
    
    for t=1:T
        
        %S=abs(reshape(S,n*m,T));
        idx=maxIndices(t,:);
        b=track(S1,n,m,r,idx(1),idx(2),t);
       
        traj{t}=b;
        
        t_calc=b;
        
        %  bestT=trajectory(v).bestT;s        
                
        t_c(:,2)=t_calc(:,1);
        t_c(:,1)=t_calc(:,2);
        t_c=t_c*2;
        
        t_c=t_c(tStart:tStop,:);        
        
        frameTrajectoryError(t,1)=norm(t_c-t_a)/length(t_c);
        
        clearvars t_c t_calc;
        
    end
    
    [err, errIdx]=min(frameTrajectoryError);
    error(id)=err;
    
    
    bestTraj{id}=traj{errIdx};
    allTraj{id}=traj;
    %count=createBins(traj,n,m);
    %[bestByDistanceAndEnergy , distanceTravelledIdx]=chooseBestTrajectory(traj);
    
    trajectory(id).trajectory=traj{errIdx};
    
    
    %[ b1 ] = track( S1,240,320,30,bestI,bestJ,bestT );
    %plotTrajectory(S1,bestTraj{id});
    
    
    idx=0;
    bestMatch=100000;
    
    %for i=1:T
    
    
    %totalDistanceError(id)=frameTrajectoryError(distanceTravelledIdx);
    
    
    %error(id)=norm(t_c-t_a)/length(t_c);
    clearvars frameTrajectoryError maxIndices traj;
    
    fprintf(fid,'Video: %d, best error: %f\n',id,error(id));
end
fprintf(fid,'Total Error %f \n',sum(error)/length(error));
fprintf(fid,'Total Error %f \n',sum(totalDistanceError)/length(totalDistanceError));
% if (norm(t_c-t_a)<=bestMatch)
%     idx=i;
%     bestMatch=norm(t_c-t_a);
% end

%end
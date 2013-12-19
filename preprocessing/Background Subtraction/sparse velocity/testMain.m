clc;clear; close all;
% 
%         X = [randn(20,2)+ones(20,2); randn(20,2)-ones(20,2)];
%         opts = statset('Display','final');
%         [cidx, ctrs] = kmeans(X, 2, 'Distance','city', ...
%                               'Replicates',5, 'Options',opts);
%         plot(X(cidx==1,1),X(cidx==1,2),'r.', ...
%              X(cidx==2,1),X(cidx==2,2),'b.', ctrs(:,1),ctrs(:,2),'kx');


mex trackFast.cpp;
load trajectoriesCalculated;
load interpolatedFullDataInStruct;

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

r=20;

totalDistanceError=0;
fid = fopen('please.txt','a+');

fprintf('current radius value, r %d\n',r);

for id=1:54
    
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
        
        
    end
    
    
    
    [val,idx]=max(S1(:));
    [a1,bestT]=ind2sub([size(S1,1) size(S1,2)],idx);
    
    [bestI,bestJ]=ind2sub([240,320],a1);
    
    
    % should it be max( abs(im(:))) ???
    
    
    % check trajectories quality
    
    trajAnnotated=data(id);
    
    % append with zeros because annotations start from the frame #3
    t_a=[zeros(2);trajAnnotated.trajectoryObject];
    
    tStart=trajAnnotated.tInteractionStart;
    tStop=trajAnnotated.tInteractionStop;
    t_a=t_a(tStart:tStop,:);
    
    
    frameTrajectoryError=zeros(T,1);
    
    
    b=track(S1,n,m,r,bestI,bestJ,bestT);
    

    t_calc=b;
    
    %  bestT=trajectory(v).bestT;s
    
    t_c(:,2)=t_calc(:,1);
    t_c(:,1)=t_calc(:,2);
    t_c=t_c*2;
    
    t_c=t_c(tStart:tStop,:);
    
    err=norm(t_c-t_a)/length(t_c);
    
    clearvars t_c t_calc;
    
    
    error(id)=err;
    
    
    
    %count=createBins(traj,n,m);
    %[bestByDistanceAndEnergy , distanceTravelledIdx]=chooseBestTrajectory(traj);
    
    trajectory(id).trajectory=b;
    
    
    %[ b1 ] = track( S1,240,320,30,bestI,bestJ,bestT );
    %plotTrajectory(S1,b1);
    
    
    %totalDistanceError(id)=frameTrajectoryError(distanceTravelledIdx);
    
    
    %error(id)=norm(t_c-t_a)/length(t_c);
    clearvars frameTrajectoryError maxIndices traj;
    
    fprintf('Video: %d, best error: %f\n',id,error(id));
end
fprintf('Total Error %f \n',sum(error)/length(error));
fprintf('Total Error %f \n',sum(totalDistanceError)/length(totalDistanceError));
% if (norm(t_c-t_a)<=bestMatch)
%     idx=i;
%     bestMatch=norm(t_c-t_a);
% end

%end
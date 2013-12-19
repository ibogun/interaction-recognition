clc;clear; close all;

%mex trackFast.cpp;
load trajectoriesCalculated;
load interpolatedFullDataInStruct;
load groundTruth;
load fromAllToOneTrajectoryIndex;

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
        
        
        [~,idx]=max(im(:));
        [x,y]=ind2sub([n,m],idx);
        maxIndices(i,:)=[x,y];
    end
    
    
   
    
    bestT=fromAllToOneTrajectoryIndex(id);
    
    %S=abs(reshape(S,n*m,T));
    idx=maxIndices(bestT,:);
    [b,P1,P2]=track(S1,n,m,r,idx(1),idx(2),bestT);
    T=size(b,1);
    
    T1=size(P1,2);
    
    
    P1=reshape(P1,240,320,T1);
    T2=size(P2,2);
    P2=reshape(P2,240,320,T2);
    
    P=zeros(240,320,T);
    P(:,:,1:bestT-1)=P1;
    P(:,:,bestT:end)=P2(:,:,bestT:end);
    P(:,:,bestT)=[];
    
    trackingProbDistr{id}=P;
%     % for t=1:T-1
%     %     imagesc(P(:,:,t))
%     %     pause(0.1);
%     % end
%     [n,m,T]=size(P);
%     [x,y,z]=meshgrid(1:n,1:m,1:T);
%     
%     % slice(P,[],[],[1 10 50]);
%     
%     frames=showVideo(P);
%     
%     
%     vidName=strcat('vids/Tracking_Probability_Distribution','_',num2str(id));
%     saveMovie(frames,vidName);
%     close all;
%     clearvars P P1 P2 bestT T1 T2 idx;
end

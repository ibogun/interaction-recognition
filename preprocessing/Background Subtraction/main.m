%clc; clear;
close all;


% current video
id=4;

% add TFOCS to your path, so change this to suit your computer
addpath /home/ibogun2010/Code/TFOCS;

%X=generateVideoVolumeFunction(framesFolder);
%[L,S]=RPCA(X);

sparseFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
sparseNames=dir(sparseFiles);
sparseNames=sparseNames(3:end);


%load c20;

load trajectoriesCalculated;

n=480;
m=640;



% find the bounding box of the largest energy in all frames

w=20;
h=20;



for id=1:length(sparseNames)
    fprintf('Current video #%d \n',id);
    currentSparseName=strcat(sparseFiles,sparseNames(id).name);
    load(currentSparseName);
    M=preprocessSparseMatrix(S,n,m);
    %[n,m,~]=size(M);
    %[bestI,bestJ,bestT]=findBestHandPosition(M,w,h);
    bestI=trajectory(id).bestI;
    bestJ=trajectory(id).bestJ;
    bestT=trajectory(id).bestT;
    % BEFORE PLOTTING SWAP AXES!!!!
    
    % for vid 6
    % bestI=170;
    % bestJ=204;
    % bestT=34;
    
%     imagesc(M(:,:,bestT));
%     rectangle('Position',[bestJ-w/2 bestI-h/2 w h],'EdgeColor','r','LineWidth',2);
%     
%     pause;
    bbForward(bestT).i=bestI;
    bbForward(bestT).j=bestJ;
    bbForward=trackForward(M,bestI,bestJ,bestT,0);
    bbBackward=trackBackward(M,bestI,bestJ,bestT,0);
    bbForward(1:bestT)=bbBackward;
    trajectory(id).trajectory=bbForward;
    trajectory(id).bestT=bestT;
    trajectory(id).bestI=bestI;
    trajectory(id).bestJ=bestJ;
end















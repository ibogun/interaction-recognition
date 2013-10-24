clc;clear; close all;

%load trajectoriesCalculated;
frameFolders='/host/Users/ibogun2010/datasets/Gupta/frames/';
f=dir(frameFolders);
f=f(3:end);

load /host/Users/ibogun2010/Dropbox/Code/interaction/preprocessing/interpolatedFullDataInStruct;
% there are 264 doublet patches in the 60x60 image
n1=264;

w=30;
h=30;

n2=144;

doubletsMatrix=zeros(n1*length(f),50);
edgeMatrix=zeros(n2*length(f),25);

c=1;
c1=1;

labelMapDoublets=1;
labelMapEdges=1;

bestT=1;

for vid=1:length(f)
    
    vidName=strcat(frameFolders,f(vid).name);
    frames=dir(vidName);
    frames=frames(3:end);
    
    
    bestT=data(vid).tInteractionStart;
       
    I=imread(strcat(vidName,'/',frames(bestT).name));
    [n,m,~]=size(I);
    
    y=data(vid).trajectoryObject(1,2);
    x=data(vid).trajectoryObject(1,1);
    % hold on
    % plot(x,y,'r.','MarkerSize',20)
    
    patch=I(max([y-h,1]):min([y+h-1,n]),max([x-w,1]):min([x+w-1,m]),:);
    %imshow(patch);
    
    
    doublets=getDoubletsFromPatch(patch);
    edges=getEdgesFromPatch(patch);
    
    d=size(doublets,1);
    d1=size(edges,1);
    
    doubletsMatrix(c:(c+d-1),:)=doublets;
    edgeMatrix(c1:(c1+d1-1),:)=edges;
    
    c1=c1+d1;
    c=c+d;
    if (vid==length(f))
       c=c-1;
       c1=c1-1;
    end
    
    labelMapDoublets=[labelMapDoublets;c];
    labelMapEdges=[labelMapEdges;c1];
end

doubletsMatrix=doubletsMatrix(1:c,:);
edgeMatrix=edgeMatrix(1:c1,:);

%labelMapEdges

clearvars -except doubletsMatrix edgeMatrix labelMapDoublets labelMapEdges;







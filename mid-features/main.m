clear;clc; close all;
strDataset='/host/Users/ibogun2010/Dropbox/Skeletton fitting/GuptaDataset';


% list directories corresponding to different videos
list=dir(strDataset);

showObject=0;

load('../interpolatedFullDataInStruct.mat');
totalNumberOfVideos=length(data);
numberOfFrames=length(data(1).trajectoryObject);

nVideo=1;

% Sparse learning parameters
param.K=50; % l e a r n s a di c ti o n a r y with 100 elemen t s
param.lambda = 0.15;
param.numThreads=4; % number o f t h r e a d s
param.batchsize =400;
param.iter=1000; % l e t us s e e what happens a f t e r 1000 i t e r a t i o n s .
%%%%%%%%%% FIRST EXPERIMENT %%%%%%%%%%%

videoDescriptor=zeros(param.K*31,totalNumberOfVideos);

% for convenience the object will be represented as keypoint+/- 32/31
% pixels around

subWindowSize=64;
%subWindowSize=48;



for nVideo=1:totalNumberOfVideos
    fprintf('Current video # %3g \n',nVideo);
    % get one video directory
    folderVar=list(nVideo+2).name;
    currentVideo=strcat(strDataset,'/',folderVar);
    video=dir(currentVideo);
    
    
    numberOfFrames=length(data(nVideo).trajectoryObject);
    X=zeros(subWindowSize*numberOfFrames,31);
    
    lastX=0;
    
    for nFrame=1:numberOfFrames
        %nFrame=1;
        % frame name variable
        frameStr=strcat(currentVideo,'/',video(nFrame+2).name);
        
        I=single(imread(frameStr));
        
        
        % HOG parameters, image is divided into 8x8 patches
        cellSize=8;
        
        
        objectPosition=data(nVideo).trajectoryObject(nFrame,:);
        
        x=round(objectPosition(1));
        y=round(objectPosition(2));
        
        
        [n,m,~]=size(I);
        
        xLow=(x-(subWindowSize/2));
        xHigh=(x+subWindowSize/2-1);
        yLow=(y-(subWindowSize/2));
        yHigh=(y+subWindowSize/2-1);
        
        if (xHigh>n)
            xHigh=n;
        end
        if (xLow<1)
            xLow=1;
        end
        
        if (yHigh>m)
            yHigh=m;
        end
        if (yLow<1)
            yLow=1;
        end
        
        
        object=zeros(subWindowSize,subWindowSize,3);
        object=single(object);
        
        object=I(xLow:xHigh,yLow:yHigh,:);
        
        
        
        hog = vl_hog(object, cellSize) ;
        
        
        if (showObject)
            % show the object and its hog descriptor
            figure;
            imshow(uint8(object));
            
            figure;
            imhog = vl_hog('render', hog) ;
            clf ; imagesc(imhog) ; colormap gray ;
        end
        %imshow(I);
        hog=reshape(hog,[],31);
        
        [nHog]=size(hog,1);
        
        X((lastX+1):lastX+nHog,:)=hog;
        lastX=lastX+nHog;
    end
    
    X=X(1:lastX,:);
    
    X=X';
    X=X-repmat(mean(X),[size(X,1) 1]);
    X=X./repmat(sqrt(sum(X.^2)),[size(X,1) 1]);
    
    
    tic
    [T,D]=evalc('mexTrainDL(X,param)');
    t=toc;
    
    clearvars x y X T;
    D=D(:);
    videoDescriptor(:,nVideo)=D;
end
















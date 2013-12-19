clc;clear; close all;


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

r=25;

totalDistanceError=0;

for id=1:54
    
    %fprintf('Current video #%d \n',id);
    currentSparseName=strcat(sparseFiles,sparseNames(id).name);
    S=load(currentSparseName);
    S1=S.S;
    Svel=zeros(size(S1,1),size(S1,2));
    %clearvars -except S1 data trajectory id;
    
    H = fspecial('disk',10);
    T=size(S1,2);
    S1(S1<0)=0;
    S1=abs(S1);
    Svel=zeros(size(S1,1),size(S1,2));
    %vidVolume=loadAllimages(fullVidNames{id},n*2,m*2);
    
    % smoothing
    for i=1:T
        
        im=S1(:,i);
        im=reshape(im,240,320);
        im=imfilter(im,H,'replicate');
        S1(:,i)=reshape(im,[],1);
        
        if (i~=1)
            Svel(:,i)=S1(:,i)-S1(:,i-1);         
            [~,idx]=max(S1(:,i));
            [x,y]=ind2sub([n,m],idx);
            maxIndices(i,:)=[x,y];
            
        end
        
        
    end
    
    
    
    [val,idx]=max(Svel(:));
    [a1,bestT]=ind2sub([size(S1,1) size(S1,2)],idx);
    
    [bestI,bestJ]=ind2sub([240,320],a1);
    
    x_s_vel=[bestJ*2,bestI*2];
    
    [val,idx]=max(S1(:));
    [a1,bestT1]=ind2sub([size(S1,1) size(S1,2)],idx);
    
    [bestI,bestJ]=ind2sub([240,320],a1);
    
    x_reg=[bestJ*2,bestI*2];
      
    % check trajectories quality
    
    trajAnnotated=data(id);
    
    % append with zeros because annotations start from the frame #3
    t_a=[zeros(2);trajAnnotated.trajectoryObject];
    
    tStart=trajAnnotated.tInteractionStart;
    tStop=trajAnnotated.tInteractionStop;
    
    
    
    
%     vidVolume=loadAllimages(fullVidNames{id},n*2,m*2);
%     b=track(S1,vidVolume,n,m,r,bestI,bestJ,bestT);
    

    l1=norm(x_s_vel-t_a(bestT,:));

    l2=norm(x_reg-t_a(bestT1,:));
    
    fprintf('Video  %d, localization  sparse velocity %f, max sparse energy: %f\n',id,l1,l2);
    
    

    
end

% if (norm(t_c-t_a)<=bestMatch)
%     idx=i;
%     bestMatch=norm(t_c-t_a);
% end

%end
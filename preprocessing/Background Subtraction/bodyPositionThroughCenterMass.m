clc;close all;clear;

sparseFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
sparseNames=dir(sparseFiles);
sparseNames=sparseNames(3:end);


bodyReference=zeros(54,2);
bodyReferenceFrameWise=cell(54,1);

for id=1:54
    
    fprintf('Current frame: %d \n',id);
    currentSparseName=strcat(sparseFiles,sparseNames(id).name);
    S=load(currentSparseName);
    S1=S.S;
    %clearvars -except S1 ;
    
    
    
    n=480;
    m=640;
    frame=1;
    
    H = fspecial('disk',10);
    % im = imfilter(im,H,'replicate');
    
    for frame=1:size(S1,2)
        im=S1(:,frame);
        %im(abs(im)<2)=0;
        im=reshape(im,n/2,m/2);
        
        im=abs(im);
        %im(im>3)=0;
        im = imfilter(im,H,'replicate');
        
        
        r=[0;0];
        total=0;
        
        im(im<1)=0;
        im(im>3)=0;
        
%         imagesc(im);
        for i=1:n/2
            for j=1:m/2
                if (im(i,j)>1 && im(i,j)<3)
                    r=r+[i;j]*1;
                    total=total+1;
                end
            end
        end
        
        
        
        r=r/total;
%         hold on;
%         plot(r(2),r(1),'b*');
%         pause(0.5);
        r=r*2;
        
        bodyTrajectory(frame,:)=r;
        %             imagesc(im);
        %             hold on;
        %             plot(r(2),r(1),'s','Color','red');
        %
        %             pause(0.4);
    end
    
    
    
    bodyReferenceFrameWise{id}=bodyTrajectory;
    
    clearvars bodyTrajectory;
    
    bodyReference(id,1)=r(1);
    bodyReference(id,2)=r(1);
end

%save('bodyReferenceThroughCenterMass','bodyReference');
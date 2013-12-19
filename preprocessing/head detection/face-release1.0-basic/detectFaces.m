%clc;clear; close all;
load face_p146_small.mat
%load multipie_independent.mat
% 5 levels for each octave
model.interval = 5;
% set up the threshold

% initially threshold is -0.65
model.thresh = min(-1, model.thresh);

% define the mapping from view-specific mixture id to viewpoint
if length(model.components)==13
    posemap = 90:-15:-90;
elseif length(model.components)==18
    posemap = [90:-15:15 0 0 0 0 0 0 -15:-15:-90];
else
    error('Can not recognize this model');
end



imageFolder='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames';
videos=dir(imageFolder);
videos=videos(3:end);

for i=1:54
    vidFullNames{i}=strcat(imageFolder,'/',videos(i).name);
end


for vid=1:54
    
    images=dir(vidFullNames{vid});
    images=images(3:end);
    
    
    nFrames=length(images);
    %headTrajectory=zeros(nFrames,2);
    tic;
    
    detections=0;
    frame=1;

    % look at only the first 11 frames
    nFrames=11;
    
    while (frame<=nFrames)
%         
%         if( detections>=9)
%             break;
%         end
        
        
        fprintf('Current video %d, frame %d \n',vid,frame);
        
        fullImName=strcat(vidFullNames{vid},'/',images(frame).name);
        
        im=imread(fullImName);
        
        %clf; imagesc(im); axis image; axis off; drawnow;
        
        bs = detect(im, model, model.thresh);
        bs = clipboxes(im, bs);
        bs = nms_face(bs,0.3);
        
        
        if (isempty(bs))
            fprintf('fail \n');
        else
            %figure,showboxes(im, bs(1),posemap),title('Highest scoring detection');
            %pause(0.5);
            %showboxes(im, bs,posemap),title('All detections above the threshold');
            
            for l=1:length(bs)
                pos=bs(l).xy;
                
                posX=(pos(:,1)+pos(:,3))/2;
                posY=(pos(:,2)+pos(:,4))/2;
                
%                 posX=mean(posX);
%                 posY=mean(posY);
                
                minPosX=min(posX);
                maxPosX=max(posX);
                
                minPosY=min(posY);
                maxPosY=max(posY);
                
                detection{l}=[minPosX,minPosY,maxPosX,maxPosY];
                detections=detections+1;
            end
            headTrajectory{frame}=detection;
            
            clearvars detection;
        end
        frame=frame+1;
        
    end
    toc;
    
    headDetectedTrajectories{vid}=headTrajectory;
    clearvars headTrajectory;
end
% show highest scoring one
%figure,showboxes(im, bs(1),posemap),title('Highest scoring detection');

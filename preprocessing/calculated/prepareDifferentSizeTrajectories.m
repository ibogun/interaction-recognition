clc; clear; close all;

load('tracks');
load('groundTruth');


% function input: struct with optical flow, bounding box dimensions (w,h)
%       tracks
% optical flow location (depends on the video)
optFlowLocation='/home/ivan/Dropbox/Code/data/optical flow/c01';
optFlowLocation='/host/Users/ibogun2010/datasets/Gupta/optical flow/c01';
i=1;
w=50;
h=50;
% get tracks of one of the videos
tracks=data(i).hand_trajs;

% number of tracks in the video
nTracks=length(tracks);

j=1;
% get one of the tracks
traj=tracks(j).traj;
score=tracks(j).score;

% get frames with detections
detections=find(score==1);

% get the size of the track
trackLength=length(score);

% velocities length is one less than total amout of points in the
% trajectory
vForward=zeros(trackLength,2);
vBackward=zeros(trackLength,2);

% get the optical flow
optFlow=prepareOptFlow(optFlowLocation);


[n,m,~]=size(optFlow(1).flow);

trajectoryForward=zeros(trackLength-1,2);

% forward
for k=1:length(detections)
    
    if (k==length(detections))
        lastIndex=trackLength;
    else
        lastIndex=(detections(k+1)-1);
    end
    
    for s=detections(k):lastIndex
        
        
        
        % get bounding box around the detection
        
        if (s==detections(k))
            % get detection with score 1
            trajectoryForward(s,:)=traj(s,:);
            top=round(traj(s,1)-(h/2));
            bot=round(traj(s,1)+(h/2));
            left=round(traj(s,2)-(w/2));
            right=round(traj(s,2)+round(w/2));
        else
            % approximate location via optical flow
            trajectoryForward(s,:)=trajectoryForward(s-1,:)+vForward(s-1,:);
            top=round(trajectoryForward(s,1)-(h/2));
            bot=round(trajectoryForward(s,1)+(h/2));
            left=round(trajectoryForward(s,2)-(w/2));
            right=round(trajectoryForward(s,2)+round(w/2));
        end
        
        if (s==1)
            continue;
        end
        
        flow=optFlow(s-1).flow;
        
        % error handling
        if (top<1)
            top=1;
        end
        
        if (bot>n)
            bot=n;
        end
        
        if (left<1)
            left=1;
        end
        
        if (right>m)
            right=m;
        end
        %fprintf('[ %f   %f],  [ %f    %f]\n',left,right,top,bot);
        objectArea=flow(top:bot,left:right,:);
        objectArea=reshape(objectArea,[],1,2);
        
        vForward(s,:)=median(objectArea);
    end
    
end


trajectoryBackwards=zeros(trackLength-1,2);

%backward
for k=length(detections):-1:1
    if (k~=1)
        firstIndex=(detections(k-1)+1);
    else
        firstIndex=1;
    end
    
    for s=detections(k):-1:firstIndex
        
        % get bounding box around the detection
        if (s==detections(k))
            trajectoryBackwards(s,:)=traj(s,:);
            top=round(traj(s,1)-(h/2));
            bot=round(traj(s,1)+(h/2));
            left=round(traj(s,2)-(w/2));
            right=round(traj(s,2)+round(w/2));
        else
            % not correct yet
            trajectoryBackwards(s,:)=trajectoryBackwards(s+1,:)-vBackward(s+1,:);
            top=round(trajectoryBackwards(s,1)-(h/2));
            bot=round(trajectoryBackwards(s,1)+(h/2));
            left=round(trajectoryBackwards(s,2)-(w/2));
            right=round(trajectoryBackwards(s,2)+round(w/2));
        end
        
        if (s==1)
            continue;
        end
        
        flow=optFlow(s-1).flow;
        
        % error handling
        if (top<1)
            top=1;
        end
        
        
        
        if (bot>n)
            bot=n;
        end
        
        if (left<1)
            left=1;
        end
        
        if (right>m)
            right=m;
        end
        %fprintf('[ %f   %f],  [ %f    %f]\n',left,right,top,bot);
     
        objectArea=flow(top:bot,left:right,:);
        objectArea=reshape(objectArea,[],1,2);
        
        vBackward(s,:)=median(objectArea);
    end
    
end
%take mean of the two
display(norm(vBackward-vForward));
v=(vBackward+vForward)/2;
%clearvars -except v;

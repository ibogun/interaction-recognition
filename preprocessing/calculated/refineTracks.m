function [ velocities ] = refineTracks( optFlow,dim, tracks )
%REFINETRACKS Calculate average
%
%   Input:
%
%       optFlow             -           data structure with optical flow
%       dim                 -           2x1 matrix with object dimensions
%       tracks              -           data structure containing
%           detections and their score (detection/no detection)
%
%   Output:
%
%       velocities          -           velocities for each track centered
%           at 'most likely location of the object'
%
%   author : Ivan Bogun
%   date   : July 8, 2013

% get dimensions
w=dim(1);
h=dim(2);

% get the size of the track
trackLength=length(tracks(1).score);

% number of tracks in the video
nTracks=length(tracks);

velocities=struct('v',[]);
velocities=repmat(velocities,nTracks,1);

[n,m,~]=size(optFlow(1).flow);
trajectoryForward=zeros(trackLength-1,2);

for j=1:nTracks
    % get one of the tracks
    traj=tracks(j).traj;
    score=tracks(j).score;
    
    % get frames with detections
    detections=find(score==1);
    
    % velocities length is one less than total amout of points in the
    % trajectory
    vForward=zeros(trackLength,2);
    vBackward=zeros(trackLength,2);
    
    
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
            objectArea=squeeze(reshape(objectArea,[],1,2));
            
            vForward(s,:)=calcAverageFlow(objectArea);
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
            objectArea=squeeze(reshape(objectArea,[],1,2));
            
            
            vBackward(s,:)=calcAverageFlow(objectArea);
        end
        
    end
    
    % v=(vForward+vBackward)/2;
    v=vBackward;
    velocities(j).v=v;
end


end


function approximation=calcAverageFlow(objectArea,epsilon)

x=objectArea(:,1);
y=objectArea(:,2);

if (nargin==1)
    epsilon=0.2;
end

rx=x(abs(x)>epsilon);
ry=y(abs(y)>epsilon);

if (isempty(rx))
    rx=mean(x);
else
    rx=mean(rx);
end

if (isempty(ry))
    ry=mean(y);
else
    ry=mean(ry);
end
rx=mean(x);
ry=mean(y);
approximation=[rx,ry];

end

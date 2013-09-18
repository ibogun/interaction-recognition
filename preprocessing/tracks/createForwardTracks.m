function [forwardTracks, trackMask] = createForwardTracks(flow, detectionFilename,withConstraints )
%CREATETRACKS This function will create tracks from detections and optical
%flow
%
%
%   Input:
%
%       flow                -           data structure containing forward
%           and backward optical flow for each frame
%       detectionFilename   -           filename with detections
%       withConstraints     -           1 - to use constraints on which
%           pixels of the optical flow to use, 0 - otherwise
%
%
%   Output:
%
%   forwardTracks           -           forward tracks
%   trackMask               -           map which shows which detections
%       corresponds to which track
%
%   Ivan Bogun
%   July 12, 2013



%sourceDetections='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';

[flowWidth,flowLength,~]=size(flow.forward(1).flow);

% example : /host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01


detections=dir(detectionFilename);
detections=detections(3:end);

n=length(detections);


detectionFrom=load(strcat(detectionFilename,'/',detections(1).name));
detectionFrom=detectionFrom.BB;
detectionFrom=round(detectionFrom(:,1:4));




% this mask will show which detection belongs to which track
trackMask=zeros(n,10);

forwardTracks=struct('track',[]);
forwardTracks=repmat(forwardTracks,1000,1);
% iterate through every frame of the video
j=1;

% tracks counter
c=1;

% overlapping parameter
epsilon=0.5;

tic
% for every frame
same=0;
for j=1:n
    fprintf('Tracks from the frame %i \n',j);
    detectionFrom=load(strcat(detectionFilename,'/',detections(j).name));
    detectionFrom=detectionFrom.BB;
    detectionFrom=round(detectionFrom(:,1:4));
    
    
    
    % for every detection
    for d=1:length(detectionFrom)
        
        
        
        
        if (trackMask(j,d)~=0)
            continue;
        end
        
        % detection
        currentPosition=detectionFrom(d,:);
        
        % track
        track=zeros(n,4);
        
        track(j,:)=currentPosition;
        
        % set the label for the track
        trackMask(j,d)=c;
        
        
        
        % for every subsequent frame
        for k=(j+1):n
            
            % get the flow
            forward=flow.forward(k-1).flow;
            backward=flow.backward(k-1).flow;
            
            detectionTo=load(strcat(detectionFilename,'/',detections(k).name));
            detectionTo=detectionTo.BB;
            detectionTo=round(detectionTo(:,1:4));
            
            currentPosition=track(j,:);
            
            % add tracking constraints from the tracking paper!!!
            % take only velocities which satisfy the constraints
            
            
            
            %fprintf('%i   %i  %i \n',j,d,k);
            
            if (currentPosition(2)<1)
                currentPosition(2)=1;
            end
            if (currentPosition(4)>flowWidth)
                currentPosition(4)=flowWidth;
            end
            
            
            if (currentPosition(1)<1)
                currentPosition(1)=1;
            end
            if (currentPosition(3)>flowLength)
                currentPosition(3)=flowLength;
            end
            
            
            
            % filter via constraints
            
            
            
            
            if (withConstraints==1)
                
                % get mask with "stable flow"
                mask=motionFilter(forward,backward,currentPosition);
                
                velX=vel(:,:,1);
                velY=vel(:,:,2);
                
                vel=[mean(velX(mask==1)), mean(velY(mask==1))];
                
            else
                vel=forward((currentPosition(2):currentPosition(4)),(currentPosition(1):currentPosition(3)),:);
                vel=squeeze(reshape(vel,[],1,2));
                vel=mean(vel,1);
                
                
            end
            
            
            
            track(k,:)=track(k-1,:)+[vel,vel];
            
            if (any(track(k,:)<0))
                fprintf('Negative detection optical flow= %f  %f \n',vel(1),vel(2));
            end
            
            position=round(track(k,:));
            
            % for every detection in the frame
            for d1=1:length(detectionTo)
                
                if (trackMask(k,d1)==0)
                    % if detectionFrom is close to detection
                    currentPosition1=detectionTo(d1,:);
                    
                    overlap=rectint([position(1:2), position(3:4)-position(1:2)],[currentPosition1(1:2), currentPosition1(3:4)-currentPosition1(1:2)]);
                    
                    area1=(abs(currentPosition1(1)-currentPosition1(3)))*(abs(currentPosition1(2)-currentPosition1(4)));
                    area2=(abs(position(1)-position(3)))*(abs(position(2)-position(4)));
                    
                    if (overlap/(area1+area2-overlap)>=epsilon)
                        % overlap
                        trackMask(k,d1)=trackMask(j,d);
                        track(k,:)=currentPosition1;
                        same=same+1;
                    else
                        % no overlap
                        
                    end
                end
                
                
                
            end
            
            
        end
        forwardTracks(c).track=track;
        c=c+1;
    end
    
end

forwardTracks=forwardTracks(1:(c-1));
toc

%clearvars  -except forwardTracks trackMask flow;

% find overlap between two detctions
% rectint([a(1:2), a(3:4)-a(1:2)],[b(1:2), b(3:4)-b(1:2)])






















end


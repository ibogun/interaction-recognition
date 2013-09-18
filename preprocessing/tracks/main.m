

sourceFlow='/host/Users/ibogun2010/datasets/Gupta/optical flow/';
listFlow=dir(sourceFlow);

imageFolder='/host/Users/ibogun2010/datasets/Gupta/frames/c01';

sourceDetections='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(sourceDetections);
listDetections=listDetections(3:end);

listFlow=listFlow(3:end);

% iterate through every video
i=1;



% example : /host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01
detectionFilename=strcat(sourceDetections,listDetections(i).name);

detections=dir(detectionFilename);
detections=detections(3:end);

n=length(detections);


detectionFrom=load(strcat(detectionFilename,'/',detections(1).name));
detectionFrom=detectionFrom.BB;
detectionFrom=round(detectionFrom(:,1:4));


[nD,~]=size(detections);

% example : /host/Users/ibogun2010/datasets/Gupta/optical flow/01.mat
flowFilename=strcat(sourceFlow,listFlow(i).name);

% load the flow
% WARNING: TAKES A LOT OF TIME, LOAD ONLY ONCE!

if (~exist('flow','var'))
    
    fprintf('Loading optical flow ... ');
    flow=load(flowFilename);
    flow=flow.optFlow;
    fprintf('Done \n');
end
[flowWidth,flowLength,~]=size(flow.forward(1).flow);



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
            
            vel=forward((currentPosition(2):currentPosition(4)),(currentPosition(1):currentPosition(3)),:);
            
            % filter via constraints
            
            
            vel=squeeze(reshape(vel,[],1,2));
            vel=mean(vel,1);
            
%             mask=motionFilter(forward,backward,currentPosition);
%             
%             velX=vel(:,:,1);
%             velY=vel(:,:,2);
%             
%             vel=[mean(velX(mask==1)), mean(velY(mask==1))]; 
            
            track(k,:)=track(k-1,:)+[vel,vel];
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

clearvars  -except forwardTracks trackMask flow;

% find overlap between two detctions
% rectint([a(1:2), a(3:4)-a(1:2)],[b(1:2), b(3:4)-b(1:2)])
















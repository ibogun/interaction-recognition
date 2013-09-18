function [ tracks ] = extrapolateTracks( tracks,flow,direction,withConstraints )
%EXTRAPOLATETRACKS Extrapolation for the tracks which started later than
%the first frame ( for forward) or which ended not on the last (backward
%tracks
%
%
%   Input:
%
%       tracks              -           data structure with tracks
%       flow                -           flow
%       direction           -           'down' for forward tracks, 'up'
%           otherwise
%       withConstraints     -           flag to filter flow or not
%
%
%   Output:
%
%   tracks                  -           interpolated tracks which start on
%       the first frame and end on the last
%
%   Ivan Bogun
%   July 12, 2013
%


n=length(tracks);
trackLength=length(tracks(1).track);
[flowWidth,flowLength,~]=size(flow.forward(1).flow);

% forward tracks, backwards interpolation
for i=1:n
    track=tracks(i).track;
    
    
    if (strcmp(direction,'down'))
        
        firstZero=find(track(:,1)==0,1,'last');
        
        % interpolation track via optical flow
        if (firstZero>0)
            
            % get first detection of the track ( for interpolation)
            currentPosition=round(track(firstZero+1,:));
            
            for j=firstZero:-1:1
                
                forward=flow.forward(j).flow;
                backward=flow.backward(j).flow;
                
                
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
                
                
                
                if (withConstraints==1)
                    
                    % get mask with "stable flow"
                    mask=motionFilter(backward,forward,currentPosition);
                    
                    velX=vel(:,:,1);
                    velY=vel(:,:,2);
                    
                    vel=[mean(velX(mask==1)), mean(velY(mask==1))];
                    
                else
                    vel=backward((currentPosition(2):currentPosition(4)),(currentPosition(1):currentPosition(3)),:);
                    vel=squeeze(reshape(vel,[],1,2));
                    vel=mean(vel,1);
                    
                    
                end
                
                
                track(j,:)=track(j+1,:)+[vel,vel];
                currentPosition=round(track(j,:));
                
            end
            
            
            
        end
        tracks(i).track=track;
    else
        
        firstZero=find(track(:,1)==0,1,'first');
        
        % interpolation track via optical flow
        if (firstZero~=n)
            
            % get first detection of the track ( for interpolation)
            currentPosition=round(track(firstZero-1,:));
            
            for j=firstZero:trackLength
                
                forward=flow.forward(j-1).flow;
                backward=flow.backward(j-1).flow;
                
                
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
                
                
                track(j,:)=track(j-1,:)+[vel,vel];
                currentPosition=round(track(j,:));
                
            end
            
            
            
        end
        
        tracks(i).track=track;
        
        
        
        
    end
end

end


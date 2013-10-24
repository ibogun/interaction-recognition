classdef trajectory
    %TRAJECTORY trajectory class which includes name of the part and
    %trajectory itself.
    %   
    %   Author:         I.Bogun (ibogun2010@my.fit.edu)
    %   Date  :         03/07/2013
    properties
        partName;             % name of the part of the body
        singlePointArray;     % array of the coordinates of the body
        % part or object
        
    end
    
    methods
        
        function obj=trajectory(partName,size)
            if (nargin>0)
                obj.partName=partName;
                var=singlePoint();
                % initialize the trajectory of bounding boxes
                obj.singlePointArray=repmat(var,size,1);
            end
        end
        
        function obj=setSinglePointAtIndex(obj,singlePoint,index)
            if (index<=length(obj.singlePointArray))
                obj.singlePointArray(index)=singlePoint;
            end
        end
        
        function array=toArray(obj)
            n=length(obj.singlePointArray);
            array=zeros(n,2);
            
            for i=1:n
                res=getPoint((obj.singlePointArray(i)));
                if (isempty(res)~=1)
                    array(i,:)=res;
                end
            end
        end
        
        function obj=interpolateTrajectory(obj)
            
            
            % cast array of objects to array of integers
            var=obj.toArray();
            
            % seperate the data to interpolate independently
            ind=3:3:length(var);
            x=var(ind,1);
            y=var(ind,2);
            
            ind=ind';
            % generate full time array
            allT=1:1:length(var);
            allT=allT';
            
            % % generate correct indices
            
            % perform interpolation
            newX=interp1(ind,x,allT);
            newY=interp1(ind,y,allT);
            
            % delete NANs from the data
            newX=newX(~isnan(newX));
            newY=newY(~isnan(newY));
            
            obj.singlePointArray=[newX newY];
            
        end
        
        function obj=resample(obj,tNewMin,tNewMax,tOldMin,tOldMax)
            
            %% Resample the trajectory
            % Resample trajectory tostart from tNewMin and end on tNewMax
            % so that the length is equal to (tMax-tMin)
            
            % load the data
            traj=obj;
            
            % get the data
            var=traj.singlePointArray;
            
            if (mod(tOldMax,3)~=0)
               if (mod(tOldMax-1,3)~=0)
                   tOldMax=tOldMax-1;
               else
                   tOldMax=tOldMax-2;
               end
            end
            
            x=var((tOldMin-2):(tOldMax-2),1);
            y=var((tOldMin-2):(tOldMax-2),2);
            
            
            % calculate scaling factor for transformations
            scalingFactor=(tNewMax-tNewMin)/(tOldMax-tOldMin);
            
            % mapping from the old to the new time scale
            scalingTransformation=@(t) scalingFactor*(t-tOldMin)+tOldMin;
            
            % get the old data in the new time scale
            oldT=tOldMin:tOldMax;
            oldT=oldT';
            
            % apply transformation
            oldTonNewScale=scalingTransformation(oldT);
            
            % values to be interpolated
            interpolateT=(tOldMin):(tOldMin+tNewMax-3);
            interpolateT=interpolateT';
            
            % to avoid float numerical overflow
            oldTonNewScale(end)=round(oldTonNewScale(end));
            
            newX=interp1(oldTonNewScale,x,interpolateT);
            newY=interp1(oldTonNewScale,y,interpolateT);
            
                        
            var=[newX newY];
            traj.singlePointArray=var;
            
            obj=traj;
        end
    end
    
end


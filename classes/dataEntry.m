classdef dataEntry
    %dataentry data structure to hold information about each video
    %   
%   Author:         I.Bogun (ibogun2010@my.fit.edu)
%   Date  :         03/07/2013
    properties
        trajectoryLefthand;
        trajectoryRighthand;
        trajectoryTorso;
        trajectoryHead;
        trajectoryObject;
        interactionName;
        tGrasp;             % time of the object grasp
        tInteractionStart;  % time of the interaction start
        tInteractionStop;   % time of the interaction end
        tPutBack;           % time when the object is being placed back
    end
    
    methods
        function obj=dataEntry(foldername)
            
            if (nargin>0)
                filelist=dir(foldername);
                
                nFrame=length(filelist)-2;
                             
                
                % initialize trajectories first
                leftHand=trajectory(partName.leftHand,nFrame);
                rightHand=trajectory(partName.rightHand,nFrame);
                torso=trajectory(partName.torso,nFrame);
                head=trajectory(partName.head,nFrame);
                object=trajectory(partName.object,nFrame);
                
                
                for iFrame=1:nFrame
                    % get the filename of the current frame to extract everything
                    % index is added by 2 since there are folders : '.' and '..'
                    currentimagename=strcat(foldername,filelist(iFrame+2).name);
                    
                    % was used to manually annotate trajectories
                    if (rem(iFrame,3)==0)
                        display('Current frame:');
                        display(iFrame);
                        i=imread(currentimagename);
                        imshow(i);
                        display('left hand');
                        singlePointVar=singlePoint(ginput(1));
                        
                        leftHand=leftHand.setSinglePointAtIndex(singlePointVar,...
                            iFrame);
                        display('torso');
                        singlePointVar=singlePoint(ginput(1));
                        torso=torso.setSinglePointAtIndex(singlePointVar,...
                            iFrame);
                        display('head');
                        singlePointVar=singlePoint(ginput(1));
                        head=head.setSinglePointAtIndex(singlePointVar,...
                            iFrame);
                        display('right hand');
                        singlePointVar=singlePoint(ginput(1));
                        rightHand=rightHand.setSinglePointAtIndex(singlePointVar,...
                            iFrame);
                        display('object');
                        singlePointVar=singlePoint(ginput(1));
                        object=object.setSinglePointAtIndex(singlePointVar,...
                            iFrame);
                        
                        
                        
                        close;
                    end
                end
                obj.trajectoryLefthand=leftHand;
                obj.trajectoryRighthand=rightHand;
                obj.trajectoryHead=head;
                obj.trajectoryTorso=torso;
                obj.trajectoryObject=object;
            end
        end
        
        function obj=interpolateRecord(obj)
            
            % interpolate every trajectory
            trajectory=obj.trajectoryHead;
            obj.trajectoryHead=trajectory.interpolateTrajectory;
            
            trajectory=obj.trajectoryLefthand;
            obj.trajectoryLefthand=trajectory.interpolateTrajectory;
            
            trajectory=obj.trajectoryObject;
            obj.trajectoryObject=trajectory.interpolateTrajectory;
            
            trajectory=obj.trajectoryRighthand;
            obj.trajectoryRighthand=trajectory.interpolateTrajectory;
            
            trajectory=obj.trajectoryTorso;
            obj.trajectoryTorso=trajectory.interpolateTrajectory;
            
        end
        
        function obj=normalizeTrajectories(obj)
            %% Data entry normalization
            % this function will normalize trajectories. It will be done by
            % setting the average of the head points as origin. To induce
            % left/right symmetry trajectories of the x axis of the left/right
            % trajectories will be calculated as
            %%
            % $|x_i - x_{head}^{average}|$
            
            record=obj;
            trajectory=record.trajectoryHead;
           
            % will only work if the trajectories are already interpolated
            if (class(trajectory.singlePointArray)~=class(1))
                
                % most likely it won't even gen here, anyway other exception will be
                % throws if something went wrong
                exception = MException('VerifyInput:WrongClass', ...
                    'Trajectories have to be of class double');
                throw(exception);
            end
            trajectory=trajectory.singlePointArray;
            
            meanTorsoPoint=mean(trajectory);
            
                        
            % substract the mean from all five trajectories of the record
            
            % head
            trajectory=record.trajectoryHead;
            
            var=trajectory.singlePointArray;
            
            var(:,1)=var(:,1)-meanTorsoPoint(1);
            var(:,2)=var(:,2)-meanTorsoPoint(2);
            
            trajectory.singlePointArray=var;
            record.trajectoryHead=trajectory;
            
            % left hand
            trajectory=record.trajectoryLefthand;
            
            var=trajectory.singlePointArray;
            
            % note that x coordinates is taken with absolute value to induce symmetry
            var(:,1)=abs(var(:,1)-meanTorsoPoint(1));
            var(:,2)=var(:,2)-meanTorsoPoint(2);
            
            trajectory.singlePointArray=var;
            record.trajectoryLefthand=trajectory;
            
            
            % right hand
            trajectory=record.trajectoryRighthand;
            
            var=trajectory.singlePointArray;
            
            % note that x coordinates is taken with absolute value to induce symmetry
            var(:,1)=abs(var(:,1)-meanTorsoPoint(1));
            var(:,2)=var(:,2)-meanTorsoPoint(2);
            
            trajectory.singlePointArray=var;
            record.trajectoryRighthand=trajectory;
            
            
            
            % object
            trajectory=record.trajectoryObject;
            
            var=trajectory.singlePointArray;
            
            % note that x coordinates is taken with absolute value to induce symmetry
            var(:,1)=abs(var(:,1)-meanTorsoPoint(1));
            var(:,2)=var(:,2)-meanTorsoPoint(2);
            
            trajectory.singlePointArray=var;
            record.trajectoryObject=trajectory;
            
            
            % torso
            trajectory=record.trajectoryTorso;
            
            var=trajectory.singlePointArray;
            
            % note that x coordinates is taken with absolute value to induce symmetry
            var(:,1)=(var(:,1)-meanTorsoPoint(1));
            var(:,2)=var(:,2)-meanTorsoPoint(2);
            
            trajectory.singlePointArray=var;
            record.trajectoryTorso=trajectory;
            
            obj=record;
            
        end
        
        function obj=resample(obj,tNewMin,tNewMax)
            % This function will resample the trajectories to fixed time
            % intervals
            
            % get the actual times of the trajectories
            tOldMin=3;
            tOldMax=length(obj.trajectoryLefthand.singlePointArray)+2;
            
            % calculate scaling factor for transformations
            scalingFactor=(tNewMax-tNewMin)/(tOldMax-tOldMin);
            
                        
            % without localization
            
%             obj.trajectoryLefthand=obj.trajectoryLefthand.resample(tNewMin,...
%                 tNewMax,tOldMin,tOldMax);
%             obj.trajectoryRighthand=obj.trajectoryRighthand.resample(tNewMin,...
%                 tNewMax,tOldMin,tOldMax);
%             obj.trajectoryTorso=obj.trajectoryTorso.resample(tNewMin,...
%                 tNewMax,tOldMin,tOldMax);
%             obj.trajectoryHead=obj.trajectoryHead.resample(tNewMin,...
%                 tNewMax,tOldMin,tOldMax);
%             obj.trajectoryObject=obj.trajectoryObject.resample(tNewMin,...
%                 tNewMax,tOldMin,tOldMax);
            
                % with localization
                
            obj.trajectoryLefthand=obj.trajectoryLefthand.resample(tNewMin,...
                tNewMax,obj.tInteractionStart,obj.tInteractionStop);
            obj.trajectoryRighthand=obj.trajectoryRighthand.resample(tNewMin,...
                tNewMax,obj.tInteractionStart,obj.tInteractionStop);
            obj.trajectoryTorso=obj.trajectoryTorso.resample(tNewMin,...
                tNewMax,obj.tInteractionStart,obj.tInteractionStop);
            obj.trajectoryHead=obj.trajectoryHead.resample(tNewMin,...
                tNewMax,obj.tInteractionStart,obj.tInteractionStop);
            obj.trajectoryObject=obj.trajectoryObject.resample(tNewMin,...
                tNewMax,obj.tInteractionStart,obj.tInteractionStop);
            
%             obj.tGrasp=round(scalingTransformation(obj.tGrasp));
%             obj.tInteractionStart=round(scalingTransformation(obj.tInteractionStart));
%             obj.tInteractionStop=round(scalingTransformation(obj.tInteractionStop));
%             obj.tPutBack=round(scalingTransformation(obj.tPutBack));
        end
        
        function stackedMatrix=toRawVector(obj)
            %% Convert trajectories to one big row vector
            % all trajectories will be stacked as [mainHand otherHand Torso Head
            % Object];
            
            record=obj;
            
            left=record.trajectoryLefthand.singlePointArray;
            right=record.trajectoryRighthand.singlePointArray;
            object=record.trajectoryObject.singlePointArray;
            head=record.trajectoryHead.singlePointArray;
            torso=record.trajectoryTorso.singlePointArray;
            
            % reshape the matrix into big raw
            left=(left(:))';
            right=(right(:))';
            object=(object(:))';
            head=(head(:)');
            torso=(torso(:))';
            
            % find p-values
            [~,p1]=corr(left',object');
            [~,p2]=corr(right',object');
            
            if (p1<p2)
                % that is left hand is more correlated with the object
                %stackedMatrix=[left right object head torso];
                stackedMatrix=[left object];
            else
                % that is right hand is more correlated with the object
                stackedMatrix=[right object];
            end
        end
    end
    
end


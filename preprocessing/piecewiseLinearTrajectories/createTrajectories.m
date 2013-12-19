%clc; clear; close all;


%load tracks;

dFolder='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01/';
files=dir(dFolder);
files=files(3:end);




n=length(files);
% load all detections into a matrix d
for i=1:length(files)
    
    dFileName=strcat(dFolder,files(i).name);
    
    load(dFileName);
    
    %load bounding box
    BB=BB(:,1:4);
    
    d{i}=BB;
end

clearvars BB dFileName dFolder files i;

all=unique([dGroup{:,:}]);
trajectory=struct('center',[],'frame_detection',[],'imagePatches',[]);
trajectory=repmat(trajectory,length(all),1);


% label counter
for l=1:length(all);
    label=all(l);
    fprintf('Current Label %d out of %d \n',l,length(all));
    
    center=zeros(n,2);
    frame_detection=zeros(n,2);
    % frame counter
    for f=1:n
        
        % detection counter
        
        for det=1:length(dGroup(f,:))
            labels=dGroup{f,det};
            
            if (ismember(label,labels))
                
                center(f,:)=findCenter(d{f}(det,:));
                frame_detection(f,:)=[f,det];
                
            end
            
        end
    end
    
    [ center ] = interpolateTrajectory( center );
    trajectory(l).center=center;
    trajectory(l).frame_detection=frame_detection;

    
end



































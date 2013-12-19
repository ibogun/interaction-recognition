clearvars -except trajectory;

load interpolatedFullDataInStruct;

imageFolder='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames';
videos=dir(imageFolder);
videos=videos(3:end);


% get images

for i=1:length(videos)
    vidName=strcat(imageFolder,'/',videos(i).name);
    
    filenames=dir(vidName);
    filenames=filenames(3:end);
    
    for j=1:length(filenames)
        fullFrameNames{j}=strcat(vidName,'/',filenames(j).name);
    end
    
    imageData{i}=fullFrameNames;
    
    clearvars fullFrameNames filenames;
end

testIm=imread(imageData{1}{1});
[n,m,~]=size(testIm);


r=30;

display('videos loaded');

for i=1:54

    count=1;
    tStart=data(i).tInteractionStart+7;
    tStop=data(i).tInteractionStop;
    
    % for calculated object
    traj=trajectory(i).trajectory;
    traj(:,3)=[];
    traj=traj*2;
    traj=[traj(:,2),traj(:,1)];
    

    % for groundtruth    
    len=length(traj);
    
    firstTrajectoryYComponent=traj(1:round(len/2),2);
    
    [~,minIdx]=max(firstTrajectoryYComponent);
    
    tStart=1;
    tStop=5;
    
    %traj=round(data(i).trajectoryObject);
    
    % for j=tStart:tStop or smth
    %j=1;
    
    for j=tStart:tStop
        

        minI=max([1,traj(minIdx,1)-r]);
        maxI=min([m,traj(minIdx,1)+r]);
        
        minJ=max([1,traj(minIdx,2)-r]);
        maxJ=min([n,traj(minIdx,2)+r]);  
        
        
        % if bounding box is small
        if (maxI-minI<r ||maxJ-minJ<r)
            continue;
        end
        
        I=imread(imageData{i}{j});
        
        patch=I(minJ:maxJ,minI:maxI,:);
        
        obj{count}=patch;
        count=count+1;
        
        % only 10 images
        if (count>5)
            break;
        end
        
    end
    
    objects{i}=obj;
    clearvars obj;
end

%check if they are empty or not

for i=1:54
    a=objects{i};
    
    for j=1:length(a)
        
        if(isempty(a{j}))
            display(i);
            display(j);
        end
    end
end



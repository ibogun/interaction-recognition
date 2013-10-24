sourceImages='/host/Users/ibogun2010/datasets/Gupta/frames/';
load('interpolatedFullDataInStruct');
listVideos=dir(sourceImages);
listVideos=listVideos(3:end);


detectionSource='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(detectionSource);
listDetections=listDetections(3:end);


prob=zeros(length(listVideos),1);
epsilon=0.2;
% iterate through every video
for i=1:length(prob)
    display(i);
    imageFilename=strcat(sourceImages,listVideos(i).name);
    
    % example : /host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01
    imagesFolder=strcat(sourceImages,listVideos(i).name);
    detectionFilename=strcat(detectionSource,listDetections(i).name);
    
    images=dir(imagesFolder);
    images=images(3:end);
    
    detections=sortInNumericalOrder(detectionFilename);
    %detections=detections(3:end);
    
    n=length(images);
    
    obj=data(i);
    l=[0,0;0,0; obj.trajectoryLeftHand];
    r=[0,0;0,0;obj.trajectoryRightHand];
    
    % set up object dimensions
    objectWidth=70;
    objectHeight=70;
    
    correct=zeros(length(detections)-2,1);
    
    
    % iterate through every image in the video
    for j=3:length(l)
        
        detectionFrom=load(strcat(detectionFilename,'/',detections{j}));
        detectionFrom=detectionFrom.BB;
        d=round(detectionFrom(:,1:4));
        
        
        for k=1:2
            leftOverlap=rectint([l(j,2)-objectHeight,l(j,1)-objectLength,objectHeight,objectLength],...
                [d(k,2),d(k,1),d(k,4)-d(k,2),d(k,3)-d(k,1)]);
            
            if (leftOverlap/(objectHeight*objectHeight+(d(k,4)-d(k,2))*...
                    (d(k,3)-d(k,1)))>=epsilon)
                correct(j-2,1)=1;
                break;
            end
            
            rightOverlap=rectint([r(j,2)-objectHeight,r(j,1)-objectLength,objectHeight,objectLength],...
                [d(k,2),d(k,1),d(k,4)-d(k,2),d(k,3)-d(k,1)]);
            
            if (rightOverlap/(objectHeight*objectHeight+(d(k,4)-d(k,2))*...
                    (d(k,3)-d(k,1)))>=epsilon)
                correct(j-2,1)=1;
                break;
            end
            
        end
        
        
    end
    
    prob(i,1)=(sum(correct)/length(correct));
end
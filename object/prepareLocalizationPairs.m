%prepareData;
%clc;clear;close all;

%load objectPosition;

threshold=6;
r=50;

for id=1:54
    
    close all;
    fprintf('Current video: %d \n',id);
    position=objectPosition{id};
    
    bestX=position(1);
    bestY=position(2);
    
    %objectPosition{id}=[bestX,bestY];
    % plotting
    
    video=getImageData(id);
    %showLocations(s,video,bestX,bestY,bestT);
    
    bestX=bestX*2;
    bestY=(bestY-10)*2;
    
    vidLength=(length(video));
    for t=1:10
        obj{t}=video{t}(bestY-r:bestY+r,bestX-r:bestX+r,:);
        %imshow(obj{t});
    end
    
    
    
    objAbsent{id}=video{round(vidLength/2)}(bestY-r:bestY+r,bestX-r:bestX+r,:);
        %imshow(obj{t});
    
    
    
    object{id}=obj;
    
    clearvars obj video;
end
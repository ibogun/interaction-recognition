%prepareData;
clc;clear;close all;


threshold=6;

r=30;
load interpolatedFullDataInStruct;
for id=1:54
    
    close all;
    
    %fprintf('Current video: %d \n',id);
    s=getSparseData(id);
    
    T=data(id).tInteractionStart;
    [bestX,bestY,bestT]=findBestLocation(s,threshold,T);
    
    objectPosition{id}=[bestX,bestY];
    % plotting
    
    video=getImageData(id);
    %showLocations(s,video,bestX,bestY,bestT);
    
    bestX=bestX*2;
    bestY=(bestY-10)*2;
    
    
    for t=1:1
        obj{t}=video{t}(bestY-r:bestY+r,bestX-r:bestX+r,:);
        imshow(obj{t});
    end
    
    object{id}=obj;
    
    clearvars obj;
end
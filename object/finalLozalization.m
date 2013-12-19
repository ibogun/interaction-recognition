clc;clear; close all;

load objectPosition.mat;
load  respectivePosition;

midPoint=[101/2,101/2];
midPoint=round(midPoint);
r=30;

show=1;

if show
    figure;
end

for id=1:54
    
    fprintf('current video: %d \n',id);
    video=getImageData(id);
    %showLocations(s,video,bestX,bestY,bestT);
    
    pos=objectPosition{id};
    respPos=respectivePosition{id};
    
    bestX=pos(1);
    bestY=pos(2);
    
    
    
    bestX=round(bestX*2);
    bestY=round((bestY-10)*2);
    
    bestX=round(bestX-(midPoint(1)-respPos(2)));
    bestY=round(bestY-(midPoint(2)-respPos(1)));
    
    for t=1:10
        
        obj{t}=video{t}(bestY-r:bestY+r,bestX-r:bestX+r,:);
        %     imshow(video{t});
        %     hold on;
        %     plot(bestX,bestY,'y+','LineWidth',15);
        
        
    end
    
    if show
        subplot(6,9,id);
        imshow(obj{t});
    end
    
    
    object{id}=obj;
    
    clearvars obj;
end

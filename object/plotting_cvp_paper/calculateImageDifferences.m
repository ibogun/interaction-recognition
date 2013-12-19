clc;clear;close all;

load imageDifference;
show=1;

if show
    figure;
end

load order;


n=length(unique(order));

sortedObjects=[];
sortedPositions=[];
for i=1:n
    ind=order==i;
    sortedObjects=[sortedObjects,imageDifference(ind)];
    sortedPositions=[sortedPositions, respectivePosition(ind)];
end

imageDifference=sortedObjects;
respectivePosition=sortedPositions;



ha = tight_subplot(6,9,[.01 .01],[.01 .01],[.01 .01]);

for id=1:54
    
    
    
    r=respectivePosition{id};
    
    diff=imageDifference{id};
    if show
        
        axes(ha(id));
        imagesc(diff);
        axis off;
        
        hold on;
        
        plot(r(2),r(1),'m+','LineWidth',8);
        hold off;
    end
    
end

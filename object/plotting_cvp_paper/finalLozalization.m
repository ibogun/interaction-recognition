clc;clear; close all;

load objectFinal;
load objectPosition.mat;
load  respectivePosition;

midPoint=[101/2,101/2];
midPoint=round(midPoint);
r=30;

show=1;

load order;
frame=1;

n=length(unique(order));

sortedObjects=[];
for i=1:n
    ind=order==i;
    sortedObjects=[sortedObjects,object(ind)];
end

object=sortedObjects;

ha = tight_subplot(6,9,[.01 .01],[.01 .01],[.01 .01]);
if show
    figure;
end

for id=1:54
    obj=object{id};

    if show
        axes(ha(id));
        imshow(obj{1});
    end
        
    
end

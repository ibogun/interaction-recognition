clc; clear;close all;
load objectsPresentAndAbsent;

figure

load order;
frame=1;

n=length(unique(order));

sortedObjects=[];
for i=1:n
    ind=order==i;
    sortedObjects=[sortedObjects,object(ind)];
end

object=sortedObjects;

for vid=1:54
    
    subplot(6,9,vid);
    
    patch=object{vid}{frame};
    imshow(patch);
    %title(num2str(order(vid)));
    
end


figure

frame=1;

for vid=1:54
    
    subplot(6,9,vid);
    
    patch=objAbsent{vid};
    imshow(patch);
    %title(num2str(order(vid)));
    
end
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



ha = tight_subplot(6,9,[.01 .01],[.01 .01],[.01 .01]);
for vid=1:54
    
    %subplot(6,9,vid);
    axes(ha(vid));
    patch=object{vid}{frame};
    imshow(patch);
    %title(num2str(order(vid)));
    
end

sortedObjects=[];
for i=1:n
    ind=order==i;
    sortedObjects=[sortedObjects,objAbsent(ind)];
end

objAbsent=sortedObjects;

figure

ha2 = tight_subplot(6,9,[.01 .01],[.01 .01],[.01 .01]);
frame=1;

for vid=1:54
    
    %subplot(6,9,vid);
    axes(ha2(vid));
    patch=objAbsent{vid};
    imshow(patch);
    %title(num2str(order(vid)));
    
end
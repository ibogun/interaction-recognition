
figure

load order;

for vid=1:54
    
    subplot(6,9,vid);
    
    patch=object{vid}{1};
    imshow(patch);
    title(num2str(order(vid)));
    
end
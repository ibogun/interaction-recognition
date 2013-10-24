bodyDetFolder='/host/Users/ibogun2010/datasets/Gupta/detections/upper body detections/c20/';
close all;
f=dir(bodyDetFolder);
f=f(3:end);


framesFolder='/host/Users/ibogun2010/datasets/Gupta/frames/c20/';
images=dir(framesFolder);
images=images(3:end);

for i=1:length(images)
    imNames{i}=strcat(framesFolder,images(i).name); %#ok<SAGROW>
end


% for every label there is a track
% for j=1:length(labels)
for j=1:length(f)
    
    file=strcat(bodyDetFolder,f(j).name);
    load(file);
    BB=BB(:,1:4);
    
    imshow(imNames{j});
    
    
    for i=1:size(BB,1)
    oldBB=BB(i,:);
    display(oldBB);
    rectangle('Position',[oldBB(1) oldBB(2) oldBB(3)-oldBB(1), oldBB(4)-oldBB(2)],'EdgeColor','r','LineWidth',2);
    %pause(0.5);
    end
    
    
end
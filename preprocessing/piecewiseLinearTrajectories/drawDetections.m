imagesFolder='/host/Users/ibogun2010/datasets/Gupta/frames/c01/';
f=dir(imagesFolder);
f=f(3:end);

label=1;
tracks=dGroup(dGroup~=0);
trackes=unique(tracks);
for j=1:length(trackes)
    label=trackes(j);
    for i=1:69
        detection=find(dGroup(i,:)==label,1,'first');
        if (isempty(detection));
            continue;
        end
        allD=d{i};
        rightD=allD(detection,:);
        
        imname=imread(strcat(imagesFolder,f(i).name));
        imshow(imname);
        
        
        oldBB=rightD;
        rectangle('Position',[oldBB(1) oldBB(2) oldBB(3)-oldBB(1), oldBB(4)-oldBB(2)],'EdgeColor','r','LineWidth',2);
        pause(0.2);
    end
    
end
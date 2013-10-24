imagesFolder='/host/Users/ibogun2010/datasets/Gupta/frames/c01/';
close all;
f=dir(imagesFolder);
f=f(3:end);

label=1;

labels=unique([dGroup{:,:}]);

% for every label there is a track
% for j=1:length(labels)
for j=266:266
    label=labels(j);
    display(label);
    % for every consecutive frame
    for i=1:69
        
        classes=dGroup(i,:);
        
        % for every possible detection
        for k=1:length(classes)
            currentRow=classes{k};
            detection=find(currentRow==label,1,'first');
            if ~isempty(detection);
                detection=k;
                break;
            end
        end
        
        
        if (isempty(detection));
            continue;
        end
        allD=d{i};
        rightD=allD(detection,:);
        
        imname=imread(strcat(imagesFolder,f(i).name));
        imshow(imname);
        
        
        oldBB=rightD;
        rectangle('Position',[oldBB(1) oldBB(2) oldBB(3)-oldBB(1), oldBB(4)-oldBB(2)],'EdgeColor','r','LineWidth',2);
        pause(0.09);
    end
    
 end
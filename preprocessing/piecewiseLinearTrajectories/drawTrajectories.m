close all;


framesFolder='/host/Users/ibogun2010/datasets/Gupta/frames/c01/';
images=dir(framesFolder);
images=images(3:end);

for i=1:length(images)
    imNames{i}=strcat(framesFolder,images(i).name); %#ok<SAGROW>
end

load trajectories;

i=265;
    
    w=40;
    h=40;
    
    t=trajectory(i).center;
    
    t1=find(t(:,1),1,'first');
    t2=find(t(:,1),1,'last');
    
    for j=1:length(f)
        if (t(j,1)==0)
            continue;
        end
        
        I=imread(imNames{j});
        
        imshow(I);
        
        hold on;
        plot(t(t1:j,1),t(t1:j,2),'r-','LineWidth',3);
%         
%         x1=t(j,1)-w/2;
%         x2=t(j,1)+w/2;
%         
%         y1=t(j,2)-h/2;
%         y2=t(j,2)+h/2;
%         
%         n=size(I,2);
%         m=size(I,1);
%         
%         if (x1<1)
%             x1=1;
%         end
%         
%         if (x2>=n)
%             x2=n;
%         end
%         
%         if (y1<1)
%             y1=1;
%         end
%         
%         if (y2>=m)
%             y2=m;
%         end
%         
%         rectangle('Position',[y1 x1 w , h],'EdgeColor','r','LineWidth',2);
         pause(0.04);
        
    end
%end
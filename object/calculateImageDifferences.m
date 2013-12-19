clc;clear;close all;

load objectsPresentAndAbsent;
show=1;

if show
    figure;
end

for id=1:54
    
    
    
    %frame=1;
    
    % take the first frame
    objPresent=object{id}{1};
    objNonPresent=objAbsent{id};
    
    colorspace='CAT02 LMS';
    
    diff=computeImageDifference(objPresent,objNonPresent,colorspace);
    
    
    % clean up the data a bit
    
    m=mean(diff(:));
    diff(diff<m)=0;
    
    
    
    [n,m]=size(diff);
    
    mask=find(diff,n*m,'first');
    
    r=[0,0];
    
    for idx=1:length(mask)
        [i,j]=ind2sub([n,m],mask(idx));
        r=r+[i,j]*diff(i,j);
    end
    
    r=r/sum(diff(:));
    
    respectivePosition{id}=r;
    
    
    if show
        
        subplot(6,9,id);
        imagesc(diff);
        
        hold on;
        
        plot(r(2),r(1),'m+','LineWidth',15);
        hold off;
    end
    
end

save('respectivePosition','respectivePosition');
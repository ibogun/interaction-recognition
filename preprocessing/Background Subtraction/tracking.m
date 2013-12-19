function [ bb ] = trackingForward( M,bestT,endT, treshold )
%TRACKING Summary of this function goes here
%   Detailed explanation goes here


%% track forward

r=20;

for t=bestT+1:endT
    
    fprintf('Current frame # %d \n',t);
    I=M(:,:,t);
    myfilter = fspecial('gaussian',[5 5], 1);
    I = imfilter(I, myfilter, 'replicate');
    
    bestSum=0;
    for i=bb(t-1).i-r:bb(t-1).i+r
        for j=bb(t-1).j-r:bb(t-1).j+r
            
            if (i+w/2>n || i-w/2<1 || j-h/2<1 ||j+h/2>m)
                continue;
            end
            
            
            window=I(i-w/2:i+w/2,j-h/2:j+h/2);
            
                      
            s=sum(window(:));
            if (s>=bestSum)
               bestSum=s;
               bb(t).t=t;
               bb(t).i=i;
               bb(t).j=j;
            end
            
            
        end
    end
    
%     if (bestSum<threshold)
%         return;
%     end
%     imagesc(I);
%     rectangle('Position',[bb(t).j-w/2 bb(t).i-h/2 w h],'EdgeColor','r','LineWidth',2);
%     pause(1);
   
end
        
        
        

end


function [ bestI,bestJ,bestT ] = findBestHandPosition( M,w,h )
%FINDBESTHANDPOSITION Summary of this function goes here
%   Detailed explanation goes here

bestMatch=0;
bestSum=0;

[n,m,T]=size(M);


for t=1:T
    %fprintf('Current frame # %d \n',t);
    I=M(:,:,t);
    myfilter = fspecial('gaussian',[5 5], 1);
    I = imfilter(I, myfilter, 'replicate');
    
    for i=1+w/2:n-w/2
        for j=1+h/2:m-h/2
            
            window=I(i-w/2:i+w/2,j-h/2:j+h/2);
            
                      
            s=sum(window(:));
            if (s>=bestSum)
               bestSum=s;
               bestT=t;
               bestI=i;
               bestJ=j;
            end
            
            
        end
    end
   
end


end


function [ bb ] = trackBackward( M,bestI,bestJ,bestT,verbose)
%TRACKBACKWARD Summary of this function goes here
%   Detailed explanation goes here


if (nargin<5)
    verbose=0;
end

% might need to be passed as well
r=30;
w=20;
h=20;

sigma=5;
sigma2=15;
[n,m,T]=size(M);



bb(bestT).i=bestI;
bb(bestT).j=bestJ;

for t=bestT-1:-1:1
    
    
    I=M(:,:,t);
    myfilter = fspecial('gaussian',[5 5], 1);
    I = imfilter(I, myfilter, 'replicate');
    
    bestSum=0;
    
    if (t==bestT-1)
        v=1;
    else
        v=[bb(t+1).i-bb(t+2).i,bb(t+1).j-bb(t+2).j];
    end
    
    for i=bb(t+1).i-r:bb(t+1).i+r
        
        sparseDenominator=I(max([1, bb(t+1).i-r-w/2]):...
            min([n,bb(t+1).i+r+w/2]),...
            max([1, bb(t+1).j-r-h/2]):min([m,bb(t+1).j+r+h/2]));
        
        sparseDenominator=sum(sparseDenominator(:));
        sparseDenominator=sum(I(:));
        
        for j=bb(t+1).j-r:bb(t+1).j+r
            
            if (i+w/2>n || i-w/2<1 || j-h/2<1 ||j+h/2>m)
                continue;
            end
            
            
            window=I(i-w/2:i+w/2,j-h/2:j+h/2);
            
            
            newV=[i-bb(t+1).i,j-bb(t+1).j];
            
            
            if (t==bestT+1)
                vProb=1;
                vProb1=1;
            else
                vProb=exp(-norm([i,j]-[bb(t+1).i,bb(t+1).j]+v)/(sigma));
                vProb1=exp(-norm(v-newV)/(sigma2));
            end
            
            
            window=I(i-w/2:i+w/2,j-h/2:j+h/2);
            
            sparseProb=sum(window(:))/sparseDenominator;
            
            %s=sum(window(:));
            s=sparseProb;
            
            
            
            %s=sum(window(:));
            if (s>=bestSum)
                bestSum=s;
                bb(t).t=t;
                bb(t).i=i;
                bb(t).j=j;
                bb(t).sparseEnergy=sum(window(:));
            end
            
            
        end
        
    end
    
    if verbose
        fprintf('Current frame # %d \n',t);
        fprintf('current energy value: %3f \n',bestSum);
        imagesc(I);
        rectangle('Position',[bb(t).j-w/2 bb(t).i-h/2 w h],'EdgeColor','r','LineWidth',2);
        pause(0.3);
    end
end

end


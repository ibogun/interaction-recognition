function [ b ] = trackMatlab(  S,cI,cJ,t, T,  n, m,  r )
%TRACKMATLAB Summary of this function goes here
%   Detailed explanation goes here



probV=1;
probH=1;

probSparse=1;

sigma1=8;
sigma2=15;

b=zeros(3,T);

maxSparse=1;

S=reshape(S,n,m,size(S,2));


for time=t:T
    
    minI=max(1,cI-r);
    minJ=max(1,cJ-r);
    
    maxI=min(n,cI+r);
    maxJ=min(m,cJ+r);
    
    currentEnergy=0;
    currentProb=0;
    
%     
%     if (time~=t)
%         Svel=S(minI:maxI,minJ:maxJ,t)-S(minI:maxI,minJ:maxJ,t-1);
%         maxSparseVel=max(Svel(:));
%     end
    Sbox=S(minI:maxI,minJ:maxJ,t);
    maxSparse=max(Sbox(:));
    
    
    
    for i=minI:maxI
        for j=minJ:maxJ
            
            
            
%             box=getBox(im,max([1,i-w]),min([n,i+w]),max([1,j-w]),min([m,j+w]));
%             
%             [h1,h2,h3]=getHistogram(box,10);
            
            %probSparse=S(i,j,time)/maxSparse;
            probSparse=exp((-(S(i,j,time)-maxSparse)^2)/(2*sigma1*sigma1));
            
            if (time~=t)
                v_next_x=i-cI;
                v_next_y=j-cJ;
                
                v_prev_x=cI-b(1,time-1);
                v_prev_y=cJ-b(2,time-1);
                
                probV=exp(-((v_next_x-v_prev_x)^2+(v_next_y-v_prev_y)^2)/(2*sigma2*sigma2));
                
                %                 probH=histSimilarity(h1,h2,h3,histArray{1,time-1},...
                %                     histArray{2,time-1},histArray{3,time-1},3);
                
                %probSvel=exp(-((S(i,j,time)-S(i,j,time-1)-maxSparseVel)^2)/(2*sigma3*sigma3));
                %probV=exp(-((i-b(1,time-1)+v_next_x)^2+((j-b(2,time-1)+v_next_y)^2)/(2*sigma*sigma)));
            else
                probV=1;
                probH=1;
            end
            
            fullProb=probSparse*probV;
            
            
            if (fullProb>=currentProb)
                currentEnergy=S(i,j,time);
                
                b(1,time)=i;
                b(2,time)=j;
                b(3,time)=currentEnergy;
                
                currentProb=fullProb;
                %
                %                 histArray{1,time}=h1;
                %                 histArray{2,time}=h2;
                %                 histArray{3,time}=h3;
            end
            
        end
    end
    
    cI=b(1,time);
    cJ=b(2,time);
    
end



end



function [box]=getBox(image,minI,maxI,minJ,maxJ)

minI=minI*2;
maxI=maxI*2;

minJ=minJ*2;
maxJ=maxJ*2;

box=image(minI:maxI,minJ:maxJ,:);

end


function res=histSimilarity(h1_1,h1_2,h1_3,h2_1,h2_2,h2_3,nOfChannels)


res=pairwiseSimilarity(h1_1,h2_1);
if (nOfChannels>1)
    res=res*pairwiseSimilarity(h1_2,h2_2);
end

if (nOfChannels>2)
    res=res*pairwiseSimilarity(h1_3,h2_3);
end


end

function res=pairwiseSimilarity(h1_1,h2_1)

histBinMap1=(h1_1~=0);
histBinMap2=(h2_1~=0);

cleanMap=(histBinMap1|histBinMap2);

h1_1_clean=h1_1(cleanMap);

h2_1_clean=h2_1(cleanMap);

x=h1_1_clean/sum(h1_1_clean);

y=h2_1_clean/sum(h2_1_clean);

res=sum((x-y).^2./(x+y)/2);

end

function [h1,h2,h3]=getHistogram(box,nBins)

%box=rgb2hsv(box);

box1=box(:,:,1);
box1=box1(:);

h1=hist(box1,nBins);

box2=box(:,:,2);
box2=box2(:);

h2=hist(box2,nBins);



box3=box(:,:,3);
box3=box3(:);

h3=hist(box3,nBins);

end
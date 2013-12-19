function [ bestX,bestY,bestT ] = findBestLocation( s,threshold,T)
%FINDBESTLOCATION Summary of this function goes here
%   Detailed explanation goes here


[n,m,~]=size(s);

bestY=0;
bestX=0;
bestT=0;



for t=5:T
    for y=1:n-20
        for x=1:m
            
            if (s(y,x,t)>=threshold)
                if (y>=bestY)
                    bestY=y;
                    bestX=x;
                    bestT=t;
                end
            end
            
        end
    end
end

end


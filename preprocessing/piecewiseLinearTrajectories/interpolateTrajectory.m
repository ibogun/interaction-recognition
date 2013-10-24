function [ trajectory ] = interpolateTrajectory( trajectory )
%INTERPOLATETRAJECTORY Summary of this function goes here
%   Detailed explanation goes here

z=(trajectory(:,1)~=0);

lastDetection=find(trajectory(:,1),1,'last');
lineStart=find(trajectory(:,1),1,'first');

for i=lineStart+1:length(z)
    if (i>=lastDetection)
        break;
    end
    
    
    
    
    if (z(i)==1 && z(i-1)==0)
        line=interpolateLine(trajectory(lineStart:i,:),lineStart,i);
        trajectory(lineStart:i,:)=line;
        lineStart=i;
    
    elseif (z(i)==1)
        lineStart=i;
    end

end


end



function [res]=interpolateLine(data,first,last)

idx=(data==0);

data=data(~idx);

t=first:last;

x=data(1:2);
y=data(3:4);

p1=polyfit([first,last],x',1);
p2=polyfit([first,last],y',1);

Xq=polyval(p1,t);
Yq=polyval(p2,t);

res=[Xq;Yq];
res=res';

end
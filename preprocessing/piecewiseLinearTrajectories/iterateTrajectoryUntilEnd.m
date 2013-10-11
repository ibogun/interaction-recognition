function [ dGroup, currentD] = iterateTrajectoryUntilEnd( frame,detection,...
    dGroup,currentD,d,frameRate)
%ITERATETRAJECTORYUNTILEND Summary of this function goes here
%   Detailed explanation goes here


% hardcoded only for the first video
if nargin<6
    frameRate=69;
end


while (frame<frameRate-5)
    [frame,detection,dGroup]=makeStep(frame,detection,dGroup,currentD,d);
    
    if (isempty(frame))
    
        break;
    end
    
    %fprintf('Frame %d, detection %d \n',frame,detection);
end

currentD=currentD+1;

end


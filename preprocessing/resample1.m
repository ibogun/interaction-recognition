function [obj]=resample1(var,tNewMin,tNewMax,tOldMin,tOldMax)
% RESAMPLE1 Resample trajectory from the one interval to another
% Resample trajectory to start from tNewMin and end on tNewMax
% so that the length is equal to (tMax-tMin).
%
%   Input:
%
%       var         -       Nx2 array of the trajectory
%       tNewMin     -       new starting t
%       tNewMax     -       new ending t
%       tOldMin     -       old starting t
%       tOldMax     -       old ending t
%
%   Output:
%
%       obj         -       trajectory of the size (tNewMax-tNewMin)x2
%           interpolated in between
%
% author: Ivan Bogun
% date  : June 6, 2013


if (mod(tOldMax,3)~=0)
    if (mod(tOldMax-1,3)~=0)
        tOldMax=tOldMax-1;
    else
        tOldMax=tOldMax-2;
    end
end

x=var((tOldMin-2):(tOldMax-2),1);
y=var((tOldMin-2):(tOldMax-2),2);


% calculate scaling factor for transformations
scalingFactor=(tNewMax-tNewMin)/(tOldMax-tOldMin);

% mapping from the old to the new time scale
scalingTransformation=@(t) scalingFactor*(t-tOldMin)+tOldMin;

% get the old data in the new time scale
oldT=tOldMin:tOldMax;
oldT=oldT';

% apply transformation
oldTonNewScale=scalingTransformation(oldT);

% values to be interpolated
interpolateT=(tOldMin):(tOldMin+tNewMax-3);
interpolateT=interpolateT';

% to avoid float numerical overflow
oldTonNewScale(end)=round(oldTonNewScale(end));

newX=interp1(oldTonNewScale,x,interpolateT);
newY=interp1(oldTonNewScale,y,interpolateT);


var=[newX newY];

obj=var;
end
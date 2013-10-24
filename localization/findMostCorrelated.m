function [ res ] = findMostCorrelated(l,r,o )
%FINDMOSTCORRELATED Find the most correlated trajectory with object
%   From the trajectories of the left and right hand (l,r respectively)
%   find the one which is the most correlated with the trajectory of the
%   object, o.
%
%   Input:
%
%       l               -           trajectory of left hand
%       r               -           trajectory of right hand
%       o               -           trajectory of the object
%
%   Output:
%
%   res             -           trejectory, either l or r, which is the 
%       most correlated with o
%
%   author: Ivan Bogun
%   date  : June 6, 2013

[~,p1]=corr(o(:),l(:));
[~,p2]=corr(o(:),r(:));

if (p2<p1)
    res=r;
else
    res=l;
end

end


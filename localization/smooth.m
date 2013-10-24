function [ smoothedTrajectory ] = smooth( trajectory, sigma )
%SMOOTH Smooth the trajectory using gaussian kernel
%
%   Input:
%       trajectory          -       trajectory to be smoothed
%       sigma               -       spread of the gaussian
%
%   Output:
%       smoothedTrajecotry  -       smoothed version of the trajectory
%
% author: Ivan Bogun
% data  : June 7, 2013

% convolution shift
nShift=floor(sigma/2);

% smoothing
gaussFilter = gausswin(sigma);
gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.

[n,m]=size(trajectory);

smoothedTrajectory=zeros(n,m);


for i=1:m
   x=conv(trajectory(:,i),gaussFilter);
   x=x(nShift+1:end-nShift);
   smoothedTrajectory(:,i)=x;
end

end


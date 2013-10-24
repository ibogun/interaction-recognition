function [ first, last ] = localizeInteraction( d,dt,toPlot,distSigma,...
    nCellsSigma )
%LOCALIZEINTERACTION Localize interaction
%   Assume that interaction is the continuous time when the distance from
%   the object to the hand performing interaction remains constant for some
%   period of time. Numerically we calculate it as a longest subsequence
%   when such condition holds
%
%
%   Input:
%
%       d               -       struct with all the data from the video
%       dt              -       threshold which defines 'how close the
%           trajectories should be'
%       toPlot          -       1 if the plot is necessary, 0 otherwise
%       distSigma       -       gaussian smoothing term hand to object
%           distances
%       nCellsSigma     -       gaussian smoothing for hand, object
%           trajectories
%
%   Output:
%
%       first           -       frame where the interaction started
%       last            -       frame where the interaction ended
%
%   author: Ivan Bogun
%   date  : June 6, 2013


if nargin<4
    %  default parameters
    distSigma=19;
    nCellsSigma=19;
    
    if nargin<3
        toPlot=0;
    end
    
    
end


l=d.trajectoryLeftHand;
r=d.trajectoryRightHand;
% get the object
o=d.trajectoryObject;

% get the right hand
hand=findMostCorrelated(l,r,o);



x=hand(:,1);
y=hand(:,2);

o_x=o(:,1);
o_y=o(:,2);

t=1:length(x);

dx=diff(x);
dy=diff(y);

o_dx=diff(o_x);
o_dy=diff(o_y);


% convolution shift
nShift=floor(nCellsSigma/2);

% smoothing
gaussFilter = gausswin(nCellsSigma);
gaussFilter = gaussFilter / sum(gaussFilter); % Normalize.

% Do the blur.
dx = conv(dx, gaussFilter);
dy = conv(dy, gaussFilter);

dx=dx(nShift+1:end-nShift);
dy=dy(nShift+1:end-nShift);

x=conv(x,gaussFilter);
y=conv(y,gaussFilter);
x=x(nShift+1:end-nShift);
y=y(nShift+1:end-nShift);

o_x=conv(o_x,gaussFilter);
o_y=conv(o_y,gaussFilter);

o_dx=conv(o_dx,gaussFilter);
o_dy=conv(o_dy,gaussFilter);

o_x=o_x(nShift+1:end-nShift);
o_y=o_y(nShift+1:end-nShift);

o_dx=o_dx(nShift+1:end-nShift);
o_dy=o_dy(nShift+1:end-nShift);


% ploting
if (toPlot==1)
    subplot(2,1,1);
    plot(x);
    hold on;
    plot(y);
    hold on;
    plot(o_x,'r');
    plot(o_y,'r');
    ylabel('coordinates','FontSize',14);
    
    
    subplot(2,1,2);
    plot(t(2:end),dx);
    hold on;
    plot(t(2:end),dy);
    hold on;
    plot(t(2:end),o_dx,'r');
    plot(t(2:end),o_dy,'r');
    
    ylabel('coordinates','FontSize',14);
    
end


n=length(o_x);
handObjectDistances=zeros(n,1);
hand_d=[x,y];
o_d=[o_x,o_y];

for i=1:n
    handObjectDistances(i)=norm(o_d(i,:)-hand_d(i,:));
end

% calculate distance vector and its velocities
handObjectDistancesVelocity=diff(handObjectDistances);
handObjectDistancesVelocity=conv(handObjectDistancesVelocity,gausswin(distSigma));

% helper variables to find the longest subsequence satisfying:
% abs(handObjectDistancesVelocity(i))<dt

if nargin<2
    % empirical estimation of the threshold
    dt=sqrt(var(handObjectDistancesVelocity));
end

% the following will find the largest subsequence satisfying
% handObjectDistancesVelocity<dt

condition=(abs(handObjectDistancesVelocity)<dt);

n=length(handObjectDistancesVelocity);
res=zeros(n,2);
counter=1;

for i=1:n
    if (condition(i)==1)
        res(counter,1)=i;
        while (condition(i)==1)
            i=i+1;
            if (i>n)
                break;
            end
        end
        res(counter,2)=i;
        counter=counter+1;
    end
end

[~, bestIndex]=max(res(:,2)-res(:,1));
first = res(bestIndex,1);
last=res(bestIndex,2);

nShiftVelocities=floor(distSigma/2);

first=first-nShiftVelocities;
last=last-2*nShiftVelocities;
if (last==-2*nShiftVelocities)
    last=length(handObjectDistancesVelocity)+2*nShiftVelocities;
end

end


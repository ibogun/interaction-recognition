function [ hand, invHand ] = preprocessTrajectory( hand,tNewMin,tNewMax,tStart,tEnd )
%PREPROCESSTRAJECTORY Summary of this function goes here
%   Detailed explanation goes here

if (nargin>1)
    hand=resample1(hand,tNewMin,tNewMax,tStart,tEnd);
end
% NORMALIZATION VIA absolute value
hand(:,2)=abs(hand(:,2));

velocity_x=diff(hand(:,1));
velocity_y=diff(hand(:,2));

invHand=[velocity_x velocity_y];

if (nargin>1)
hand=hand(:)';
invHand=invHand(:)';
end
end


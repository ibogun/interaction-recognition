function [  ] = plotTrajectory( S,b )
%PLOTTRAJECTORY Summary of this function goes here
%   Detailed explanation goes here


% S is assumed to be 2 dimensional
T=size(S,2);

traj=b(:,1:2);

for i=1:T

    im=S(:,i);
    im=reshape(im,240,320);
    imagesc(im);
    
    %for ii=1:length(locs)
    pos=traj(i,:);
    
    hold on;
    plot(pos(2),pos(1),'x','Color','black','LineWidth',12);
    %end
    pause(0.3);
end


end


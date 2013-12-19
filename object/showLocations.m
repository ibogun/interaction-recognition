function [  ] = showLocations( s,vid,bestX,bestY,bestT )
%SHOWLOCATIONSINSPARSEDOMAIN Summary of this function goes here
%   Detailed explanation goes here

% imagesc(s(:,:,bestT));
% hold on;
% plot(bestX,bestY,'b*');
% 
% pause(1);

T=length(vid);


figure;
for t=1:T
    
    subplot(1,2,1);
    imagesc(s(:,:,t));
    hold on;
    plot(bestX,bestY,'r*');
    
    subplot(1,2,2);
    imshow(vid{t});
    hold on;
    
    plot(bestX*2,bestY*2,'r*');
    
    pause(0.3);
    hold off;
end

close all;

end


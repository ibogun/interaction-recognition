function [ b1 ] = track( S,r,bestI,bestJ,t )
%TRACK Summary of this function goes here
%   Detailed explanation goes here

b1=trackInDirection(S,r,bestI,bestJ,t,1);
b2=trackInDirection(S,r,bestI,bestJ,t,0);

b1(1:t)=b2;

end



function [b]=trackInDirection(S,r,bestI,bestJ,t,direction)

%S is assumed to be three dimensional sparse matrix, smoothed already
[n,m,T]=size(S);


% positive direction, going forward
if direction
    
    cI=bestI;
    cJ=bestJ;
    
    % for each consecutive frame, starting at t find the maximum  within
    % r radius
    
    for tt=t:T
        
        % get the sizes of the bounding window
        minIidx=max([1,cI-r]);
        minJidx=max([1,cJ-r]);
        
        maxIidx=min([n,cI+r]);
        maxJidx=min([m,cJ+r]);
        
        I=abs(S(:,:,tt));
        
        % get the windows from S
        w=I(minIidx:maxIidx,minJidx:maxJidx);
        
        % find it's sizes
        [w_n,w_m]=size(w);
        
        % find it's maximum
        [maxEnergy,idx]=max(w(:));
        
        % get two-dimensional index
        [idx_i,idx_j]=ind2sub([w_n,w_m],idx);
        
        % get position in the full image
        bestI_tt=idx_i+minIidx-1;
        bestJ_tt=idx_j+minJidx-1;
        
        %for the next frame reinitialize the indices
        cI=bestI_tt;
        cJ=bestJ_tt;
        
        b(tt).i=cI;
        b(tt).j=cJ;
        b(tt).sparseEnergy=maxEnergy;
        
    end
    
    
    
    
    
    
else
    % going backwards
    
    % cut everything coming after t
    S=S(:,:,1:t);
    
    % flip so that tracking forward would work
    S=flipdim(S,3);
    
    % start with 1, because the flipped version will end with t
    b=trackInDirection(S,r,bestI,bestJ,1,1);
    
    % flip it back
    b=b(end:-1:1);
    
end





end
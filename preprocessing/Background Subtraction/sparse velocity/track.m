function [ b1,P1,P2] = track( S,n,m,r,bestI,bestJ,t )
%TRACK Summary of this function goes here
%   Detailed explanation goes here

T=size(S,2);


if (t+1<=T)
    [b1,P2]=trackInDirection(S,n,m,r,bestI,bestJ,t+1,1);
end
b1(t,1)=bestI;
b1(t,2)=bestJ;
b1(t,3)=S((bestJ-1)*n+bestI,t);

if (t-1>=1)
    [b2,P1]=trackInDirection(S,n,m,r,bestI,bestJ,t-1,0);
    b1(1:t-1,:)=b2;
end


end



function [b,P]=trackInDirection(S,n,m,r,bestI,bestJ,t,direction)

%S is assumed to be three dimensional sparse matrix, smoothed already
[~,T]=size(S);



% positive direction, going forward
if direction
    
    % make it two dim for the C++ code
    
    
    cI=bestI;
    cJ=bestJ;
    
    % for each consecutive frame, starting at t find the maximum  within
    % r radius
   
    
    [b,P]=trackFast(S,cI,cJ,t,T,n,m,r);
    %b1=trackMatlab(S,cI,cJ,t,T,n,m,r);
    %display(norm(b-b1));
    b=b';
    
    
else
    % going backwards
    
    % cut everything coming after t
    S=S(:,1:t);
    
    
    
    % flip so that tracking forward would work
    S=flipdim(S,2);
   
    
    % start with 1, because the flipped version will end with t
    [b,P]=trackInDirection(S,n,m,r,bestI,bestJ,1,t);
    
    % flip it back
    b=b(end:-1:1,:);
    
end





end
function [ M ] = preprocessSparseMatrix( S,n,m )
%PREPROCESSSPARSEMATRIX Summary of this function goes here
%   Detailed explanation goes here

T=size(S,2);

M=zeros(n/2,m/2,T);

for i=1:T
   
    s=S(:,i);
    s=reshape(s,n/2,m/2);
    M(:,:,i)=abs(s);

   
    
end


end


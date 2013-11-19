function [ Kobj ] = getObjectKernel( Pz_d )
%GETOBJECTKERNEL Summary of this function goes here
%   Detailed explanation goes here


n=length(Pz_d);

Kobj=zeros(n,n);


for i=1:n
    for j=1:n
        Kobj(i,j)=Pz_d(i,:)*Pz_d(j,:)';
    end
end

end


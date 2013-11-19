function [ r ] = mappingFromSortedToReal( pz,order)
%MAPPINGFROMSORTEDTOREAL Summary of this function goes here
%   Detailed explanation goes here

a1=find(order==1,20,'first');
a2=find(order==2,20,'first');
a3=find(order==3,20,'first');
a4=find(order==4,20,'first');

s=[ones(length(a1),1)', 2*ones(length(a2),1)', 3*ones(length(a3),1)',4*ones(length(a4),1)'];

b1=find(s==1,20,'first');
b2=find(s==2,20,'first');
b3=find(s==3,20,'first');
b4=find(s==4,20,'first');

n1=length(a1);
n2=length(a2);
n3=length(a3);
n4=length(a4);

r=zeros(54,1);

for i=1:n1
    
    r(b1(i))=pz(a1(i));
end

for i=1:n2
    
    r(b2(i))=pz(a2(i));
end

for i=1:n3
    
    r(b3(i))=pz(a3(i));
end

for i=1:n4
    
    r(b4(i))=pz(a4(i));
end


end


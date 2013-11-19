function [ mapping ] = fixingBrokenOrderForCells( order, newOrder )
%FIXINGBROKENORDERFORCELLS Summary of this function goes here
%   Detailed explanation goes here

n=length(order);

mapping=zeros(n,1);

for i=1:n
   el=order(i);
   
   map=find(newOrder==el,1,'first');
   mapping(i)=map;
   newOrder(map)=0;
    
end

end


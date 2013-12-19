function [ res] = findCenter( bb)
%FINDCENTER Summary of this function goes here
%   Detailed explanation goes here

if (isempty(bb))
    res=[];
else
    
    res=[ (bb(1)+bb(3))/2; (bb(2)+bb(4))/2];
end


end


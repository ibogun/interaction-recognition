function [ res ] = sumWeightsNormal(x,weights,centers,sigmas )
%SUMWEIGHTSNORMAL Summary of this function goes here
%   Detailed explanation goes here

n=length(weights);

res=0;
for i=1:1
    res=res+weights(i)*mvnpdf(x,centers(i),sigmas);
end

end


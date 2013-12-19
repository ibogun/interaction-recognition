function [ potential_outlier ] = fitLine( centers )
%FITLINE Summary of this function goes here
%   Detailed explanation goes here
X=centers(:,1);
Y=centers(:,2);

% Use regstats to calculate Cook's Distance
stats = regstats(Y,X,'linear');

% if Cook's Distance > n/4 is a typical treshold that is used to suggest
% the presence of an outlier
potential_outlier = stats.cookd > 4/length(X);

end


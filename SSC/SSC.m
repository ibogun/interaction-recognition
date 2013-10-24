%--------------------------------------------------------------------------
% This is the main function for running SSC.
% Load the DxN matrix X representing N data points in the D dim. space
% living in a union of n low-dim. subspaces.
% The projection step onto the r-dimensional space is arbitrary and can
% be skipped. In the case of using projection there are different types of
% projections possible: 'NormalProj', 'BernoulliProj', 'PCA'. Please refer
% to DataProjection.m for more information.
%--------------------------------------------------------------------------
% X: DxN matrix of N points in D-dim. space living in n low-dim. subspaces
% s: groundtruth for the segmentation
% n: number of subspaces
% r: dimension of the projection e.g. r = d*n (d: max subspace dim.)
% Cst: 1 if using the constraint sum(c)=1 in Lasso, else 0
% OptM: optimization method {'L1Perfect','L1Noise','Lasso','L1ED'}, see
% SparseCoefRecovery.m for more information
% lambda: regularization parameter for 'Lasso' typically in [0.001,0.01]
% or the noise level for 'L1Noise'. See SparseCoefRecovery.m for more
% information.
% K: number of largest coefficients to pick in order to build the
% similarity graph, typically K = max{subspace dimensions}
% Missrate: vector of misclassification rates
%--------------------------------------------------------------------------
% In order to run the code CVX package must be installed in Matlab. It can
% be downlaoded from http://cvxr.com/cvx/download
%--------------------------------------------------------------------------
% Copyright @ Ehsan Elhamifar, 2010
%--------------------------------------------------------------------------

n = 6; %Number of subspaces
X=dataMatrix;
s = groundTruth; %Generating the ground-truth for evaluating clustering results
lambda = 0.01; %Regularization parameter in 'Lasso' or the noise level for 'L1Noise'


CMat = calculateSparseCoefficients(X,lambda);

K=3; % how many coefficients to pick, usually its dim( largest subspace) +1, try 4

CKSym = BuildAdjacency(CMat,K);
[Grps , SingVals, LapKernel] = SpectralClustering(CKSym,n);
[Missrate, confusionMatrix,preficted] = Misclassification(Grps,s);
display(confusionMatrix);
display(min(Missrate));
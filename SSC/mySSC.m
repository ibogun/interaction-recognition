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

D = 54; %Dimension of ambient space
n = 6; %Number of subspaces
X = dataMatrix;
s = groundTruth; %Generating the ground-truth for evaluating clustering results
r =0; %Enter the projection dimension e.g. r = d*n, enter r = 0 to not project
Cst = 0; %Enter 1 to use the additional affine constraint sum(c) == 1
OptM = 'Lasso'; %OptM can be {'L1Perfect','L1Noise','Lasso','L1ED'}
lambda = 0.001; %Regularization parameter in 'Lasso' or the noise level for 'L1Noise'
K =0; %Number of top coefficients to build the similarity graph, enter K=0 for using the whole coefficients
if Cst == 1
    K = 2 + 1; %For affine subspaces, the number of coefficients to pick is dimension + 1
end

Xp = DataProjection(X,r,'NormalProj');
CMat = calculateSparseCoefficients( Xp,lambda);
[CMatC,sc,OutlierIndx,Fail] = OutlierDetection(CMat,s);
if (Fail == 0)
    CKSym = BuildAdjacency(CMatC,K);
    [Grps , SingVals, LapKernel] = SpectralClustering(CKSym,n);
    [Missrate,confusionMatrix, prediction]= Misclassification(Grps,sc);
    display(confusionMatrix);
    display(Missrate);
end
visualizeConfusionMatrix( confusionMatrix )

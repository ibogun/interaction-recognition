load('dataMatrix');
load('groundTruth');

D = 54; %Dimension of ambient space
n = 6; %Number of subspaces
X = dataMatrix;
s = groundTruth; %Generating the ground-truth for evaluating clustering results
r =0; %Enter the projection dimension e.g. r = d*n, enter r = 0 to not project
Cst = 0; %Enter 1 to use the additional affine constraint sum(c) == 1
OptM = 'Lasso'; %OptM can be {'L1Perfect','L1Noise','Lasso','L1ED'}
lambda = 0.01; %Regularization parameter in 'Lasso' or the noise level for 'L1Noise'
K =0; %Number of top coefficients to build the similarity graph, enter K=0 for using the whole coefficients
if Cst == 1
    K = 2 + 1; %For affine subspaces, the number of coefficients to pick is dimension + 1
end

Xp = DataProjection(X,r,'NormalProj');
CMat = SparseCoefRecovery(Xp,Cst,OptM,lambda);
[CMatC,sc,OutlierIndx,Fail] = OutlierDetection(CMat,s);
if (Fail == 0)
    CKSym = BuildAdjacency(CMatC,K);
    [Grps , SingVals, LapKernel] = SpectralClustering(CKSym,n);
    [Missrate,confusionMatrix, prediction]= Misclassification(Grps,sc);
    display(confusionMatrix);
    display(Missrate);
end
%visualizeConfusionMatrix( confusionMatrix )

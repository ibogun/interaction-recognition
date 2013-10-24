kernel{1}=getKernel('gaussianAlignment',10);

X=trajectoriesArray(2,:);
tic
[accuracy, predictedValues]=leaveOneOut(X,groundTruth,1,kernel,'QuiLane2009');
toc
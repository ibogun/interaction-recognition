function [ accuracy, predictedValues] = leaveOneOut( X,groundTruth,C,kernel,method)
%LEAVEONEOUT Perform leave-one-out cross validation
%   Detailed explanation goes here

%kernel=getKernel('gaussianAlignment',sigma);

n=size(X,2);
nClasses=6;
predictedValues=zeros(n,nClasses);

for i=1:n
    predictors=cell(nClasses,1);
    fprintf('Current iteration %i out of %i \n',i,n);
    for k=1:nClasses
        
        % set up ground truth
        data=X;
        y=-ones(1,54);
        y(groundTruth==k)=1;
        
        y(i)=[];
        data(:,i)=[];
        
        predictors{k,1}=trainSVM( data,y',kernel,C,method);
        predictedValues(i,k)=predictors{k,1}(X(:,i));
        %fprintf('value for the %i classifier %g \n',k,predictedLabels(i,k));
        
    end
    
end
% find max labels
[~,b]=max(predictedValues,[],2);
% find accuracy
accuracy=length(find(b==groundTruth'))/n;

end


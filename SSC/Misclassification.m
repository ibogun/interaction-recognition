%--------------------------------------------------------------------------
% This function takes the groups resulted from spectral clutsering and the
% ground truth to compute the misclassification rate.
% groups: [grp1,grp2,grp3] for three different forms of Spectral Clustering
% s: ground truth vector
% Missrate: 3x1 vector with misclassification rates of three forms of
% spectral clustering
%--------------------------------------------------------------------------
% Copyright @ Ehsan Elhamifar, 2010
%--------------------------------------------------------------------------


function [Missrate, confMatrix, predictedClasses] = Misclassification(groups,s)

n = max(s);
Missrate=zeros(3,1);
C=unique(s);
nSize=length(C);
permutation=zeros(3,nSize);
for i = 1:3
    [Missrate(i,1),permutation(i,:)] = missclassGroups( groups(:,i),s,n );
    Missrate(i,1)=Missrate(i,1)/ length(s);
end

[res index]=min(Missrate);



confMatrix=zeros(nSize,nSize);
bestPermutation=permutation(index,:);

% for i=1:nSize
%     for j=1:nSize
%         %confMatrix(groups(i)
%     end
% end

% find inverse permutation

p=1:length(C);
p=[bestPermutation;p]';
p=sortrows(p);
inversePermutation=p(:,2)';
for i=1: length(s)
    %confMatrix(bestPermutation(s(i)),(groups(i,index)))=confMatrix(bestPermutation(s(i)),groups(i,index))+1;
    confMatrix((s(i)),inversePermutation((groups(i,index))))=confMatrix((s(i)),inversePermutation(groups(i,index)))+1;
end

predictedClasses=inversePermutation((groups(:,index)));

confusionTarget=zeros(nSize,length(s));
confusionPredicted=zeros(nSize,length(s));

for i=1:length(s)
    confusionTarget(s(i),i)=1;
    confusionPredicted(inversePermutation(groups(i,index)),i)=1;
end


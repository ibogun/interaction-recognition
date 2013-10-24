

nClusters=55;

[A1,C1]=kmeans(doubletsMatrix,nClusters,'MaxIter',5,'EmptyAction','drop');
[A2,C2]=kmeans(edgeMatrix,nClusters,'MaxIter',5,'EmptyAction','drop');

%%

n=54;

frequenciesDoublets=zeros(n,nClusters);
frequenciesEdges=zeros(n,nClusters);

for i=2:n+1
    
    a=A1(labelMapDoublets(i-1):labelMapDoublets(i));
    b=hist(double(a),nClusters);
    frequenciesDoublets(i-1,:)=b;
    
    a=A2(labelMapEdges(i-1):labelMapEdges(i));
    b=hist(double(a),nClusters);
    frequenciesEdges(i-1,:)=b;
    
end

%clearvars -except frequenciesDoublets frequenciesEdges;


[prob1,~,~,~]=pLSA_EMmodified(frequenciesDoublets,4);
[prob2,~,~,~]=pLSA_EMmodified(frequenciesEdges,4);
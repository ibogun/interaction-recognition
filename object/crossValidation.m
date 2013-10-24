load order

labels=order;

doubletsCorrect=0;
edgesCorrect=0;
combined=0;

Par.maxit  = 100;
Par.Leps   = 0.1;
Par.doplot = 0;

for i=1:length(labels)
    labels=order;;
    labels(i)=0;
    [prob1,~,~,~]=pLSA_EMmodified(frequenciesDoublets,4,Par,labels);
    [prob2,~,~,~]=pLSA_EMmodified(frequenciesEdges,4,Par,labels);
    
    [a,b]=max(prob1');
    if (b(i)==order(i))
        doubletsCorrect=doubletsCorrect+1;
    end
    
    [a,b]=max(prob2');
    if (b(i)==order(i))
        edgesCorrect=edgesCorrect+1;
    end
    
    prob=prob1.*prob2;
    
    [a,b]=max(prob');
    if (b(i)==order(i))
        combined=combined+1;
    end
    
end
fprintf('Doublets: \n');
display(doubletsCorrect/length(labels));
fprintf('Edges: \n');
display(edgesCorrect/length(labels));
fprintf('Combined: \n');
display(combined/length(labels));
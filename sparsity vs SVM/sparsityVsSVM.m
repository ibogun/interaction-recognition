total=sum(yTrain==1);
[sortedValues,sortIndex] = sort(alpha(:),'descend');  %# Sort the values in
%#   descending order
maxIndex = sortIndex(1:total);  %# Get a linear index into A of the 5 largest values

posres=0;
tot=0;
c=C(:,1);

for i=1:54
    if (yTrain(i)==1)
        
        c=C(:,i);
        [sortedVal,sortInd] = sort(c(:),'descend');  %# Sort the values in
        %#   descending order
        last=length(sortedVal(sortedVal>0));
        
        lastIndex=min(last,total);
        currentMaxIndex = sortInd(1:lastIndex);  %# Get a linear index into A of the 5 largest values
        
        members=ismember(currentMaxIndex,maxIndex);
        
        posres=posres+sum(members);
        
        tot=tot+length(currentMaxIndex);
        
    end
end
display('Sparse+support vectors');
display(posres);
display('Total number of support vectors');
display(tot);
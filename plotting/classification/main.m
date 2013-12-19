

n=length(combinedDE);

accuracy=zeros(n,1);


for i=1:n
   accuracy(i)=1-combinedDE{i}.missrate; 
end


variance=sqrt((1/(n-1))*sum((accuracy-mean(accuracy)).^2));
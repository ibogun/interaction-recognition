
[m,n]=size(dataMatrix);

xTrain=dataMatrix;
c=10000;
currentClass=6;
%% primal
% cvx_begin
% cvx_precision high
% variables w(m) e(n) b;
% minimize (1/2*pow_pos(norm(w,2),2)+C*sum(e));
% subject to
%     for i=1:n
%        yTrain(i)*(w'*xTrain(i,:)'+b)>=1-e(i);
%        e(i)>=0;
%     end
% 
% cvx_end
% 
% primal=cvx_optval;

%% dual


% set y's
yTrain=-ones(n,1);
mX=mean(dataMatrix,2);
for i=1:n
    dataMatrix(:,i)=dataMatrix(:,i)-mX;
   if (groundTruth(i)==currentClass)
       yTrain(i)=1;
   end
end


K=zeros(n,n);
for i=1:n
    for j=1:n
    
       K(i,j)=dot(xTrain(:,i),xTrain(:,j));
        
    end
end

A=diag(yTrain);

cvx_begin
cvx_precision high
%cvx_solver sedumi
variables alpha(n);

maximize (sum(alpha)-0.5*quad_form(A*alpha,K));
subject to
    for i=1:n
       alpha(i)>=0;
     %  alpha(i)<=c;
    end
        diag(A)'*alpha==0;

cvx_end
alpha=alpha/sum(alpha);
dual=cvx_optval;

sparsityVsSVM;

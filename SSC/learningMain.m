
[~,m]=size(X);
D = size(Xp,1);
N = size(Xp,2);
lambda=1000;

K=zeros(N-1,N-1);
Kv_y=zeros(N-1,1);

% kernel function

% linear kernel
%kernel=@(x,y) x'*y;

% polynomial kernel
% p=1;
% kernel=@(x,y) (x'*y+1)^p;

% gaussian kernel
%
kernel=@(x,y) normpdf(norm(x-y),0,100);

kernel=@(x,y) 1 - sum((x - y).^2 ./ (x + y) / 2);
for i = 1:N
    fprintf(1,'%3g data record out of %3g \n',i,N);
    y = Xp(:,i);
    if i == 1
        Y = Xp(:,i+1:end);
    elseif ( (i > 1) && (i < N) )
        Y = [Xp(:,1:i-1) Xp(:,i+1:N)];
    else
        Y = Xp(:,1:N-1);
    end
    
    Kv_y=Y'*y;
    K_yy=kernel(y,y);
    % K_yy=1;
    
    for s=1:(N-1)
        Kv_y(s)=kernel(Y(:,s),y);
        for j=1:(N-1)
            %             if (s==j)
            %                 K(s,j)=1;
            %             else
            K(s,j)=kernel(Y(:,s),Y(:,j));
            
        end
    end
    
    %version 1
    cvx_begin;
    
    cvx_quiet true;
    cvx_precision high
    variable c(N-1,1);
    minimize( norm(c,1)+lambda*(K_yy-2*c'*(Kv_y)+quad_form(c,K)));
    subject to
    
    cvx_end;
    
    % version 2
    %     cvx_begin;
    %
    %     cvx_quiet true;
    %     cvx_precision high
    %     variable c(N-1,1);
    %     minimize( norm(c,1));
    %     subject to
    %     (K_yy-2*c'*(Kv_y)+quad_form(c,K))<=lambda;
    %     cvx_end;
    
    
    if (sum(isnan(c))>0)
        break;
    end
    
    % place 0's in the diagonals of the coefficient matrix
    if i == 1
        CMat(1,1) = 0;
        CMat(2:N,1) = c(1:N-1);
    elseif ( (i > 1) && (i < N) )
        CMat(1:i-1,i) = c(1:i-1);
        CMat(i,i) = 0;
        CMat(i+1:N,i) = c(i:N-1);
    else
        CMat(1:N-1,N) = c(1:N-1);
        CMat(N,N) = 0;
    end
end


k=0; % how many coefficients to pick, usually its dim( largest subspace) +1, try 4

CKSym = BuildAdjacency(CMat,k);
n=6;
[Grps , SingVals, LapKernel] = SpectralClustering(CKSym,n);
[Missrate, confusionMatrix,preficted] = Misclassification(Grps,groundTruth);
display(confusionMatrix);
display(min(Missrate));
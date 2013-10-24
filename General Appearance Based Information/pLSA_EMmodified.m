% function [Pw_z,Pz_d,Pz,Li, ] = pLSA_EM(X,K,Par, labels, initialPz_d)
%
% Probabilistic Latent semantic alnalysis (pLSA)
%
% Notation:
% X ... (m x nd) term-document matrix (observed data)
%       X(i,j) stores number of occurrences of word i in document j
%
% m  ... number of words (vocabulary size)
% nd ... number of documents
% K  ... number of topics
% labels ... for supervised learning
%
% Li   ... likelihood for each iteration
% Pz   ... P(z)
% Pz_d ... P(d|z) 
% Pw_z ... P(w|z) corresponds to beta parameter in LDA
%
% Pz_wd ... P(z|w,d) posterior on z
%
% 
% References: 
% [1] Thomas Hofmann: Probabilistic Latent Semantic Analysis, 
% Proc. of the 15th Conf. on Uncertainty in Artificial Intelligence (UAI'99) 
% [2] Thomas Hofmann: Unsupervised Learning by Probabilistic Latent Semantic
% Analysis, Machine Learning Journal, 42(1), 2001, pp.177.196 
%
% Josef Sivic
% josef@robots.ox.ac.uk
% 30/7/2004

function [Pw_z,Pz_d,Pz,Li] = pLSA_EMmodified(X, K, Par, labels, initialPz_d)

if nargin<3
   Par.maxit  = 100;
   Par.Leps   = 1;   
   Par.doplot = 0;
end;   

if Par.doplot
   ff(1)=figure(1); clf;
   %set(ff(1),'Position',[1137         772         452         344]);
   title('Log-likelihood');
   xlabel('Iteration'); ylabel('Log-likelihood');
   %figure(2); clf; 
end;


m  = size(X,1); % vocabulary size
nd = size(X,2); % # of documents

% initialize Pz, Pz_d,Pw_z
[Pz,Pz_d,Pw_z] = pLSA_init(m,nd,K);

if(nargin < 5)
    initialPz_d = [];
elseif(nargin == 5)
    if(size(initialPz_d, 1) == nd && size(initialPz_d, 2) == K)
        Pz_d = initialPz_d;
    end
end

% allocate memory for the posterior
Pz_dw = zeros(m,nd,K);

Li    = [];
maxit = Par.maxit;

% EM algorithm
for it = 1:maxit   
   %fprintf('Iteration %d ',it);
   
   % E-step
   Pz_dw = pLSA_Estep(Pw_z, Pz_d);
   
   % M-step
   if(nargin < 4)
       labels = [];
   end
   [Pw_z,Pz_d,Pz] = pLSA_Mstep(X,Pz_dw, labels, it);
   if Par.doplot>=2
     Pw_z
   end;  
   
   % Evaluate data log-likelihood
   Li(it) = pLSA_logL(X,Pw_z,Pz,Pz_d);   
        
   % plot loglikelihood
   if Par.doplot>=3
      figure(ff(1));
      plot(Li,'b.-');
   end;
      
   
   % convergence?
   dLi = 0;
   if it > 1
     dLi    = abs(Li(it) - Li(it-1));
     % disp(['Li' num2str(it) ' = ' num2str(Li(it))]);
     if dLi < Par.Leps, break; end;   
   end;
   %fprintf('dLi=%f \n',dLi);
end;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% initialize conditional probabilities for EM 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Pz,Pz_d,Pw_z] = pLSA_init(m,nd,K)
% m  ... number of words (vocabulary size)
% nd ... number of documents
% K  ... number of topics
%
% Pz   ... P(z)
% Pz_d ... P(d|z)
% Pw_z ... P(w|z)

Pz   = ones(K,1)/K; % uniform prior on topics

% random assignment
Pz_d = rand(nd,K);   % word probabilities conditioned on topic
C    = 1./sum(Pz_d,1);  % normalize to sum to 1
Pz_d = Pz_d * diag(C);

% random assignment
Pw_z = rand(m,K);
C    = 1./sum(Pw_z,1);    % normalize to sum to 1
Pw_z = Pw_z * diag(C);

return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (1) E step compute posterior on z,  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function Pz_dw = pLSA_Estep(Pw_z,Pz_d)
   K = size(Pw_z,2);

   for k = 1:K
      Pz_dw(:,:,k) = Pw_z(:,k) * Pz_d(:,k)';
   end;   
   C = sum(Pz_dw,3);

   % normalize posterior
   for k = 1:K
      Pz_dw(:,:,k) = Pz_dw(:,:,k) .* (1./C);
   end;   
return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%  (2) M step, maximazize log-likelihood
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Pw_z,Pz_d,Pz] = pLSA_Mstep(X,Pz_dw, labels, it)
   K = size(Pz_dw,3);   % number of Topics
   
   for k = 1:K
      Pw_z(:,k) = sum(X .* Pz_dw(:,:,k),2) + 1;
   end;
   
   for k = 1:K
      Pz_d(:,k) = sum(X.* Pz_dw(:,:,k),1)';
   end;
   
   Pz = sum(Pz_d,1);
   
   % normalize to sum to 1
   C = sum(Pw_z,1) + size(Pz_dw, 1);
   Pw_z = Pw_z * diag(1./C);
   
   if(~isempty(labels))
        if(it == 1)
            for video = 1 : length(labels)
                if(labels(video) ~= 0)
                    Pz_d(video, :) = 0;
                    Pz_d(video, labels(video)) = 1;
                end
            end
        end
        
        for video = 1 : length(labels)
            Pz_d(video, :) = Pz_d(video, :) ./ sum(Pz_d(video, :));
        end
   else
       C = sum(Pz_d,1);
       Pz_d = Pz_d * diag(1./C);
   end
   
   C = sum(Pz,2);
   Pz = Pz .* 1./C;
   Pz;
return;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% data log-likelihood
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function L = pLSA_logL(X,Pw_z,Pz,Pz_d)
   L = sum(sum(X .* log(Pw_z * diag(Pz) * Pz_d' + eps)));
return;



return;
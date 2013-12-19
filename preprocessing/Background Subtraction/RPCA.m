function [ LL,SS ] = RPCA( X,lambda)
%RPCA Robust principal component analysis on X
%   L+S decomposition of X, X=L+S.
%
%   Input:
%       X               -       NxT where
%       lambda          -       parameter of the decomposition
%
%   Output:
%       LL              -       low-rank component
%       SS              -       sparse component
%
% author: Ivan Bogun
% data: 02/12/2013



%%
nFrames     = size(X,2);


if nargin<2
    lambda  = 1e-2;
end
opts = [];
opts.stopCrit       = 4;
opts.printEvery     = 1;
opts.tol            = 1e-4;

opts.maxIts         = 25;

opts.errFcn{1}      = @(f,d,p) norm(p{1}+p{2}-X,'fro')/norm(X,'fro');

largescale      = false;

for inequality_constraints = 1:1
    
    
    if inequality_constraints
        % if we already have equality constraint solution,
        %   it would make sense to "warm-start":
        %         x0      = { LL_0, SS_0 };
        % but it's more fair to start all over:
        x0      = { X, zeros(size(X))   };
        z0      = [];
    else
        x0      = { X, zeros(size(X))   };
        z0      = [];
    end
    
    
    obj    = { prox_nuclear(1,largescale), prox_l1(lambda) };
    affine = { 1, 1, -X };
    
    mu = 1e-4;
    if inequality_constraints
        epsilon  = 0.5;
        dualProx = prox_l1(epsilon);
    else
        dualProx = proj_Rn;
    end
    
    tic
    % call the TFOCS solver:
    [x,out,optsOut] = tfocs_SCD( obj, affine, dualProx, mu, x0, z0, opts);
    toc
    
    % save the variables
    LL =x{1};
    SS =x{2};
    if ~inequality_constraints
        z0      = out.dual;
        LL_0    = LL;
        SS_0    = SS;
    end
    
end % end loop over "inequality_constriants" variable

end


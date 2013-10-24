calc=load('calculatedTrajectoryLocalization');
real=load('annotatedTrajectoryLocalization');

calc=calc.clusteringResults;
real=real.clusteringResults;

minima=1000;
n=length(real);
%fid = fopen(strcat('calcutedVSrealWithVelocitiesTrajectorySize=100.txt'),'w');
for i=1:n
    kernel=calc(i).kernel;
    lambda=calc(i).lambda;
    K=calc(i).K;
    par=calc(i).parameter;
    missCalc=calc(i).missClassification;
    missReal=real(i).missClassification;
    
    if (minima>missReal)
        best=i;
    end
    
    minima=min([missCalc,missReal,minima]);
    if (strcmp('ERROR',kernel)~=1)
        fprintf('kernel=%5s lambda=%5g, parameter=%5g, K=%3g, miss real=%5g, miss calc=%5g \n',...
            kernel,lambda,par,K,missReal,missCalc);
    end
end

display(minima);
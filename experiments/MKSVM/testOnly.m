
C=[ 1 10 100 1000];
sigma=[0.1 1 10 100 1000];
load groundTruth;
X=trajectoriesArray;
Y=trajectoriesArray;
Z=trajectoriesArray;
fid = fopen('All possible kernels calculated.txt','a+');
fprintf(fid,'Linear combination of the trajectories, velocities smoothed and localized with limits on the energy.\n...Trajectories were calculated from energy only.\n with gaussian alignment kernel for sigma=0.1,1,10,100,1000\n kernels are normalized K(i,j)=K(i,j)/sqrt(K(i,i)*K(j,j))\n');
maxAccuracy=0;
accuracy=0;
counter=0;

clearvars kernel;

for j=1:length(sigma)
    
    kernel{j}=getKernel('gaussianAlignment',sigma(j));
    kernel{j+length(sigma)}=getKernel('gaussianAlignment',sigma(j));
    X(j,:)=Z(1,:);
    Y(j,:)=Z(2,:);
    %kernel{3}=Kobj;
end
%kernel{2*length(sigma)+1}=Kobj;
X=[X;Y];
K=calculateKernel(X,kernel);

for i=1:length(C)
    
    %K(:,:,3)=Kobj;e
    
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'QuiLane2009');
    
    fprintf(fid,'method=QuiLane2009 C=%f, accuracy=%f \n',C(i),accuracy);
    
        
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Lanckriet2004a');
    
    fprintf(fid,'method=Lanckriet2004a C=%f,  accuracy=%f \n',C(i),accuracy);
    
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Cortes2010a');
    
    fprintf(fid,'method=Cortes2010a C=%f,  accuracy=%f \n',C(i),accuracy);
    
    
end

fclose(fid);
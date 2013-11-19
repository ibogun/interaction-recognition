
C=[10];
sigma=[0.1 1 10 100 1000];
%sigma=[1 10 100];
load groundTruth;
load Kobj;
X=trajectoriesArray;
Y=trajectoriesArray;
Z=trajectoriesArray;
%fid = fopen('All possible kernels calculated.txt','a+');
fprintf(strcat('max energy over all trajectories \n'));
maxAccuracy=0;
accuracy=0;
counter=0;

clearvars kernel;

for j=1:length(sigma)
    
    kernel{j}=getKernel('gaussianAlignment',sigma(j));
    kernel{j+length(sigma)}=getKernel('gaussianAlignment',sigma(j));
    X(j,:)=Z(1,:);
    Y(j,:)=Z(2,:);
    kernel{3}=Kobj;
end
kernel{2*length(sigma)+1}=Kobj;
X=[X;Y];
K=calculateKernel(X,kernel);

for i=1:length(C)
    
    %K(:,:,3)=Kobj;e
    
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Cortes2010a');
    
    fprintf('method=QuiLane2009 C=%f, accuracy=%f \n',C(i),accuracy);

    
    
end

%fclose(fid);
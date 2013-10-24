
C=[0.1 1 10 100 1000];
sigma=[0.1 1 10 100 1000];
X=trajectoriesArray;
Y=trajectoriesArray;
fid = fopen('All possible kernels try#1.txt','w');
fprintf(fid,'Linear combination of the trajectories, velocities\n with gaussian alignment kernel for sigma=0.1,1,10,100,1000\n kernels are normalized K(i,j)=K(i,j)/sqrt(K(i,i)*K(j,j))\n');
maxAccuracy=0;
accuracy=0;
counter=0;



for j=1:length(sigma)
    
    kernel{j}=getKernel('gaussianAlignment',sigma(j));
    kernel{j+length(sigma)}=getKernel('gaussianAlignment',sigma(j));
    X(j,:)=X(1,:);
    Y(j,:)=Y(2,:);
    %kernel{3}=Kobj;
end
    %kernel{2*length(sigma)+1}=Kobj;
    X=[X;Y];
    K=calculateKernel(X,kernel);
   
for i=1:length(C)

    %K(:,:,3)=Kobj;
    
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'QuiLane2009');
    
    fprintf(fid,'method=QuiLane2009 C=%f, accuracy=%f \n',C(i),accuracy);
    
    
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Lanckriet2004a');
    
    fprintf(fid,'method=Lanckriet2004a C=%f,  accuracy=%f \n',C(i),accuracy);
    
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Cortes2010a');
    
    fprintf(fid,'method=Cortes2010a C=%f,  accuracy=%f \n',C(i),accuracy);
    
    
%         [accuracy, ~]=leaveOneOut(K1,groundTruth,C(i),'QuiLane2009');
%     
%     fprintf(fid1,'method=QuiLane2009 C=%f, accuracy=%f',C(i),accuracy);
%     
%     
%     [accuracy, ~]=leaveOneOut(K1,groundTruth,C(i),'Lanckriet2004a');
%     
%     fprintf(fid1,'method=Lanckriet2004a C=%f, sigma=%f, accuracy=%f',C(i),accuracy);
%     
%     [accuracy, ~]=leaveOneOut(K1,groundTruth,C(i),'Cortes2010a');
%     
%     fprintf(fid1,'method=Cortes2010a C=%f, sigma=%f, accuracy=%f',C(i),accuracy);
    
end


fclose(fid);

%clc
C=[0.1 1 10 100];
%sigma=[0.1 1 10 100 ];
%sigma=[1 10 100];
sigma=1;
load groundTruth;
load postProcessedTrajectoriesArray;
%load calculatedKobj;
%load bestCalculatedObjectKernel;
%load Kobj;

% fixing broken order
%groundTruth=groundTruth(a);


X=trajectoriesArray;
Y=trajectoriesArray;
Z=trajectoriesArray;
% 
% z1=trajectoriesArray(1,:);
% z1=z1(a);
% 
% Z(1,:)=z1;
% 
% z1=trajectoriesArray(2,:);
% z1=z1(a);
% 
% 
% Z(2,:)=z1;


fid = fopen('Final many kernels One sigma.txt','a+');
fprintf(fid,strcat('Trajectories without velocities \n'));
fprintf(fid,strcat('With addition of object probabilities\n'));
maxAccuracy=0;
accuracy=0;
counter=0;

clearvars kernel;

for j=1:length(sigma)
    
    kernel{j}=getKernel('gaussianAlignment',sigma(j));
    kernel{j+length(sigma)}=getKernel('gaussianAlignment',sigma(j));
    X(j,:)=Z(1,:);
    Y(j,:)=Z(2,:);
    
end

%Kobj=KobjGroundTruth;
kernel{length(sigma)+1}=Kobj;
%kernel{2*length(sigma)+2}=getDistanceKernel(trajectoriesArray);
X=[X;Y];
%X=Y;
% clearvars kernel;
% kernel{1}=Kobj;
% kernel{2}=Kobj;
K=calculateKernel(X,kernel);

%
for i=1:length(C)
    
     
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'QuiLane2009');
    
    fprintf(fid,'method=QuiLane2009 C=%f, accuracy=%f \n',C(i),accuracy);
    
        
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Lanckriet2004a');
    
    fprintf(fid,'method=Lanckriet2004a C=%f,  accuracy=%f \n',C(i),accuracy);
    
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Cortes2010a');
    
    fprintf(fid,'method=Cortes2010a C=%f,  accuracy=%f \n',C(i),accuracy);
    
    
end

%fclose(fid);
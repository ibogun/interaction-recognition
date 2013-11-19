%clc
C=1;
sigma=100;
%sigma=[1 10 100];
%sigma=1;
load groundTruth;
load postProcessedTrajectoriesArray;
%load calculatedKobj;
%load bestCalculatedObjectKernel;
%load Kobj;


X=trajectoriesArray;
Y=trajectoriesArray;
Z=trajectoriesArray;


fileMany='Final many kernels Many sigmas.txt';
fileOne='Final many kernels One sigma.txt';

fileTest='debugging.txt';

fid = fopen(fileTest,'a+');

fprintf(fid,strcat('Many sigmas + trajectories only\n'));
fprintf(fid,strcat('With addition of object probabilities\n'));
maxAccuracy=0;
accuracy=0;
counter=0;

clearvars kernel;

for j=1:length(sigma)
    
    kernel{j}=getKernel('gaussianAlignment',sigma(j));
    kernel{j+length(sigma)}=getKernel('gaussianAlignment',sigma(j));
    X(j,:)=Z(2,:);
    Y(j,:)=Z(2,:);
    
end

%Kobj=KobjGroundTruth;
kernel{2*length(sigma)+1}=Kobj;
%kernel{2*length(sigma)+2}=getDistanceKernel(trajectoriesArray);
X=[X;Y];
%X=Y;
% clearvars kernel;
% kernel{1}=Kobj;
% kernel{2}=Kobj;
K=calculateKernel(X,kernel);

% n=size(K,3);
% 
% K1=K(:,:,1);
% for i=2:n
%    K1=K1.*K(:,:,i); 
% end
% 
% K=K1;
% n=size(K,1);
% 
% for i=1:n
%     for j=1:n
%         K(i,j)=K(i,j)/sqrt(K(i,i)*K(j,j));
%     end
% end

%K=Kobj;
%
for i=1:length(C)
    
     
    [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'QuiLane2009');
    
    fprintf(fid,'method=multiplication C=%f, accuracy=%f \n',C(i),accuracy);
    
        
%     [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Lanckriet2004a');
%     
%     fprintf(fid,'method=Lanckriet2004a C=%f,  accuracy=%f \n',C(i),accuracy);
%     
%     [accuracy, ~]=leaveOneOut(K,groundTruth,C(i),'Cortes2010a');
%     
%     fprintf(fid,'method=Cortes2010a C=%f,  accuracy=%f \n',C(i),accuracy);
    
    
end

%fclose(fid);
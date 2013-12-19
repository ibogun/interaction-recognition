clc;clear; close all;
load combinedPerfect10Frames;
load order;


C=[1];
sigma=[10 100 ];
%sigma=[1 10 100];
%sigma=1;
load groundTruth;
load postProcessedTrajectoriesArray;

X=trajectoriesArray;
Y=trajectoriesArray;
Z=trajectoriesArray;

clearvars kernel;

for j=1:length(sigma)
    
    kernel{j}=getKernel('gaussianAlignment',sigma(j));
    kernel{j+length(sigma)}=getKernel('gaussianAlignment',sigma(j));
    X(j,:)=Z(1,:);
    Y(j,:)=Z(2,:);
    
end

%Kobj=KobjGroundTruth;

%kernel{2*length(sigma)+2}=getDistanceKernel(trajectoriesArray);
X=[X;Y];
%X=Y;
% clearvars kernel;
% kernel{1}=Kobj;
% kernel{2}=Kobj;




for j=1:length(combinedDE)
    pz=combinedDE{j}.Pz_d;
    
    order=order';
    
    map=fixingBrokenOrderForCells(order,sort(order));
    a=sort(order);
    
    new_pz=zeros(54,4);
    
    for i=1:54
        new_pz(i,:)=pz(map(i),:);
    end
    
    Kobj=getObjectKernel(new_pz);
    
    
    kernel{2*length(sigma)+1}=Kobj;
    K=calculateKernel(X,kernel);
    
%     K1=ones(54);
%     for i=1:size(K,3)
%         K1=K1.*K(:,:,i);
%     end
%     
%     K=K1;
    
    
    [accuracy, predictedValues]=leaveOneOut(K,groundTruth,C,'QuiLane2009');
    
    fprintf('method=QuiLane2009 C=%f, accuracy=%f \n',C,accuracy);
    acc(j)=accuracy;
    pred{j}=predictedValues;
    
    
    [accuracy, ~]=leaveOneOut(K,groundTruth,C,'Cortes2010a');
    
    fprintf('method=Cortes2010a C=%f,  accuracy=%f \n',C,accuracy);
    acc1(j)=accuracy;
    
end
%clearvars -except Kobj;
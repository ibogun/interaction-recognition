% X=trajectoriesArray(1,:);
% n=length(X);
% nClasses=6;
% 
% % current class learning
% 
% C=[0.001, 0.01 , 0.1 1 10 100 1000 10000];
% sigma=[0.1 1 10 100 1000 10000];
% 
% tic
% fid = fopen('Trajectories Only leave-one out cross validation.txt','w');
% fprintf(fid,'This file contains results of the leave-one-out cross validation \nusing kernel SVM with unbalanced data experiments with annotated trajectories\n');
% maxAccuracy=0;
% total=2*length(C)*length(sigma);
% counter=0;
% accuracy=0;
% for i=1:length(C)
%     for j=1:length(sigma)
%         counter=counter+1;
%         fprintf('Iteration %i out of %i \n',counter,total);
%         try
%             [accuracy, predictedValues]=leaveOneOut(X,groundTruth,C(i),sigma(j));
%             fprintf(fid,'C=%f, sigma=%f, accuracy=%f',C(i),sigma(j),accuracy);
%         catch err
%             fprintf(fid,'C=%f, sigma=%f, ERROR',C(i),sigma(j));
%         end
%         if (accuracy>maxAccuracy)
%             bestPredictedValues=predictedValues;
%             bestC=C(i);
%             bestSigma=sigma(j);
%         end
%     end
% end
% fclose(fid);
% savefile='trajBest';
% save(savefile,'bestPredictedValues');

C=[0.001, 0.01 , 0.1 1 10 100 1000 1000];
sigma=[0.1 1 10 100 1000 10000];

X=trajectoriesArray(2,:);
fid = fopen('Velocities Only leave-one out cross validation.txt','w');
fprintf(fid,'This file contains results of the leave-one-out cross validation \n using kernel SVM with unbalanced data experiments with velocities from annotated trajectories\n');
maxAccuracy=0;
accuracy=0;

total=length(C)*length(sigma);
counter=0;

for i=1:length(C)
    for j=1:length(sigma)
        counter=counter+1;
        kernel{1}=getKernel('gaussianAlignment',sigma(j));
        fprintf('Iteration %i out of %i',counter,total);
        
        try
            [accuracy, predictedValues]=leaveOneOut(X,groundTruth,C(i),kernel,'QuiLane2009');
                        fprintf(fid,'C=%f, sigma=%f, accuracy=%f',C(i),sigma(j),accuracy);
        catch err
            fprintf(fid,'C=%f, sigma=%f, ERROR',C(i),sigma(j));
        end
        if (accuracy>maxAccuracy)
            bestVelPredictedValues=predictedValues;
            bestVelCC=C(i);
            bestVelSigma=sigma(j);
        end
    end
end
fclose(fid);
savefile='velBest';
save(savefile,'bestPredictedValues');
toc

clc;clear; close all;


load interpolatedFullDataInStruct;
load trajectoriesCalculated;

total=0;
localization=zeros(54,1);
for v=1:54
    
    clearvars t_c;
    % append with zeros because annotations start from the frame #3
    t_a=[zeros(2);data(v).trajectoryObject];
    t_calc=trajectory(v).trajectory;
    
    bestT=trajectory(v).bestT;
    
    
    
    t_c(:,2)=[t_calc.i];
    t_c(:,1)=[t_calc.j];
    t_c=t_c*2;
    
    localization(v)=norm(t_a(bestT,:)-t_c(bestT,:));
    
    n=min(size(t_a,1),size(t_c,1));
    norms=zeros(n,1);
    for i=3:n
        norms(i)=norm(t_a(i,:)-t_c(i,:));
    end
    
    s=sum(norms)/n;
    total=total+s;
    fprintf('Current video %d, total norm sum: %f \n',v,s);
end



total=total/54;
fprintf('Total Error %f \n',total);
fprintf('Localization Error %f \n',sum(localization)/54);
%clc;clear; close all;

%load bodyReferenceThroughCenterMass;
load ../interpolatedFullDataInStruct;

total=0;
for i=1:54
    
    t_a=mean(data(i).trajectoryTorso);
    t_c=bodyReference(i,:);
    res=norm(t_a-t_c);
    
    total=total+res;
    fprintf('Current video %d, torso error %f \n',i,res);
end
total=total/54;
fprintf('Total average: %f \n',total);
load combinedED;
load order;

n=length(combinedED);

pz=combinedED{1}.Pz_d;
pz=(pz);
for i=2:n
    pz=pz+((combinedED{i}.Pz_d));
end
pz=combinedED{3}.Pz_d;

order=order';

map=fixingBrokenOrderForCells(order,sort(order));
a=sort(order);

% check
%display(norm(a(map)-order));

new_pz=zeros(54,4);
%pred=combinedED{3}.predictedClasses;

% for i=1:54
%     pred(i)=pred(a(i));
%    new_pz(i,:)=pz(a(i),:); 
% end

for i=1:54
   new_pz(i,:)=pz(map(i),:); 
end

Kobj=getObjectKernel(new_pz);

clearvars -except Kobj;
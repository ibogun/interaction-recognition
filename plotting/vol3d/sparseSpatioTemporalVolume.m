clc;clear; close all;

sparseFiles='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/sparse/';
sparseNames=dir(sparseFiles);
sparseNames=sparseNames(3:end);


id=1;

smooth=0;


H = fspecial('disk',10);


fprintf('Current video #%d \n',id);
currentSparseName=strcat(sparseFiles,sparseNames(id).name);
S=load(currentSparseName);
S1=S.S;

%clearvars -except S1 ;

n=480/2;
m=640/2;
r=15;

T=size(S1,2);

D=zeros(n,m,T);

for t=1:T
    D(:,:,t)=reshape(S1(:,t),n,m);
end

D=abs(D);
D(D<5)=0;
figure;
subplot(1,2,1);
D = squeeze(D);
h = vol3d('cdata',D,'texture','3D');
view(3);  
axis tight;  
daspect([1 1 .4]);
alphamap('rampup');
alphamap(.3 .* alphamap);
set( gcf, 'Color', 'w' );
%title( 'Making a call', 'FontSize', 15 );   
colormap cool;
set(gca,'fontsize',20)


id=5;

smooth=0;


H = fspecial('disk',10);


fprintf('Current video #%d \n',id);
currentSparseName=strcat(sparseFiles,sparseNames(id).name);
S=load(currentSparseName);
S1=S.S;

%clearvars -except S1 ;

n=480/2;
m=640/2;
r=15;

T=size(S1,2);

D=zeros(n,m,T);

for t=1:T
    D(:,:,t)=reshape(S1(:,t),n,m);
end

D=abs(D);
D(D<5)=0;
%figure;
subplot(1,2,2);
D = squeeze(D);
h = vol3d('cdata',D,'texture','3D');
view(3);  
axis tight;  
daspect([1 1 .4]);
alphamap('rampup');
alphamap(.3 .* alphamap);
set( gcf, 'Color', 'w' );
%title( 'Making a call', 'FontSize', 15 );   
colormap cool;
set(gca,'fontsize',20)
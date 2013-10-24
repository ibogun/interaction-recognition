clc;clear; close all;

load('L+S');

m=480/2;
n=640/2;

nFrames=size(LL_0,2);

bSub=struct('L',[],'S',[]);
bSub=repmat(bSub,nFrames,1);

%nFrames=1;

for i=1:nFrames
    display(i);
    bSub(i).L=reshape(LL_0(:,i),m,n);
    bSub(i).S=reshape(SS_0(:,i),m,n);
    %surf(bSub(i).S);
    %pause;
end
savefile='L+S_video_01';
save(savefile,'bSub');

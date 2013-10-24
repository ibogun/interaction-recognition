function [ similarity ] = trajectorySimilarity(t1,t2,imNames,sigma,verbose)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here


if (nargin<4)
    sigma=[10,5,10];
end

if (nargin<5)
    verbose=0;
end

% assume trajectory two starts after trajectory one

% last non-zero entry in the trajectory one
lastT1=find(t1(:,1),1,'last');

% first non-zero enrty in the trajectory two
firstT2=find(t2(:,1),1,'first');

% if second trajectory ends before the first one
lastT2=find(t2(:,1),1,'last');
if (lastT2<=lastT1)
    similarity=0;
    return;
end

% if there is overlap between two trajectories
if (firstT2<lastT1)
    firstT2=lastT1;
end

% it is assumed that firstT2>=lastT1
delta=5;

% if we cannot find sample big enough
if (lastT2<=firstT2+delta)
    similarity=0;
    return;
end

sampleT1=t1(lastT1-delta:lastT1,:);
sampleT2=t2(firstT2:firstT2+delta,:);

% get velocities
[~,v1]=gradient(sampleT1);
[~,v2]=gradient(sampleT2);


v1=v1';
v2=v2';

w=1:length(v1);
w=w/sum(w);

v1=bsxfun(@times,v1,w);
v2=bsxfun(@times,v2,w);

v1=mean(v1,2);
v2=mean(v2,2);

% just mean values of the velocities
% v1=[ mean(v1(:,1)), mean(v1(:,2))];
% v2=[ mean(v2(:,2)), mean(v2(:,2))];



f=@(x,sigma) exp(- (1/(sigma^2))*x);


% motion similarity
phi_m=f(norm(v1-v2),sigma(2));

% appearance similarty
% not implemented yet ( histograms over sift, hog features?)
phi_a=1;

im1=imread(imNames{lastT1});
im2=imread(imNames{firstT2});

h=60;
w=60;

pos1=round(t1(lastT1,:));
pos2=round(t2(firstT2,:));

%patch1=im1(pos1(1)-h/2:pos1(1)+h/2,pos1(2)-w/2:pos1(2)+w/2,:);
%patch2=im2(pos2(1)-h/2:pos2(1)+h/2,pos2(2)-w/2:pos2(2)+w/2,:);

patch1=getSubImage(im1,pos1(2)-h/2,pos1(2)+h/2,pos1(1)-w/2,pos1(1)+w/2);
patch2=getSubImage(im2,pos2(2)-h/2,pos2(2)+h/2,pos2(1)-w/2,pos2(1)+w/2);

phi_a=calculateAppearanceSimilarity(patch1,patch2,64);

% occlusion similarity
phi_o=f(norm(t1(lastT1,:)-t2(firstT2,:)+(firstT2-lastT1)*v1'),sigma(3));

similarity=phi_a*phi_m*phi_o;

if verbose
fprintf('Motion similarity: %f; Occlusion similarity: %f \n',phi_m,phi_o);
end

end



function [h1,h2]=calculateHistograms(im, nBins)



im=reshape(im,[],1,3);
im=squeeze(double(im));


rgb2o1=@(x) (x(:,1)-x(:,2))/2;
rgb2o2=@(x) (2*(x(:,1)-x(:,2)-x(:,3))/4);

o1=rgb2o1(im);
o2=rgb2o2(im);

% # of elements in the bins
bins=linspace(-255/2,255/2,nBins);

[h1,~]=histc(o1,bins);
[h2,~]=histc(o2,bins);


end

function [s]=calculateAppearanceSimilarity(im1,im2,nBins)

if (nargin<3)
    nBins=16;
end


[h1_o1,h1_o2]=calculateHistograms(im1,nBins);
[h2_o1,h2_o2]=calculateHistograms(im2,nBins);

h1_o1=h1_o1/sum(h1_o1);
h2_o1=h2_o1/sum(h2_o1);

h1_o2=h1_o2/sum(h1_o2);
h2_o2=h2_o2/sum(h2_o2);

s1=chi_square_statistics_fast(h1_o1',h2_o1');
s2=chi_square_statistics_fast(h1_o2',h2_o2');

s=(1-s1)*(1-s2);

end


function patch=getSubImage(I,x1,x2,y1,y2)


n=size(I,1);
m=size(I,2);

if (x1<1)
   x1=1; 
end

if (x2>=n)
    x2=n;
end

if (y1<1)
   y1=1; 
end

if (y2>=m)
    y2=m;
end



patch=I(x1:x2,y1:y2,:);


end































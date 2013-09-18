function [ mask ] = motionFilter( forward,backward,rectangle)
%MOTIONFILTER Estimate stable* relative motion
%   Filter incorectly estimated optical flow and estimate the average
%   motion in the rectangle.
%
%   Input:
%
%       forward             -           forward optical flow
%       backward            -           backward optical flow
%       rectangle           -           rectangle where the motion should
%           be estimated
%
%       position            -           current position
%
%
%   Output:
%
%       mask                  -           binary mask of pixels which pass
%       optical flow consistency as inspired from the paper "Dense Point
%       Trajectories by GPU-accelerated LDOF"
%
% Ivan Bogun
% July 10, 2013
%
% Note: only the first condition is implemented, denoted by (5) in the
% paper

%To Do


if (nargin==3)
    x=(rectangle(1):rectangle(3));
    y=(rectangle(2):rectangle(4));
else
    [n,m,~]=size(forward);
    x=1:n;
    y=1:m;
end

all=zeros(length(x)*length(y),2);
approximation=zeros(length(x)*length(y),2);
mask=zeros(length(x),length(y));

epsilon=0.5;


for i=1:length(x)
    for j=1:length(y)
        all(j+(i-1)*length(y),:)=[x(i), y(j)]+squeeze(forward(x(i),y(j),:))';
        approximation(j+(i-1)*length(y),:)=bilinearInterpolation(...
            backward,all(j+(i-1)*length(y),:));
        
        to=squeeze(forward(x(i),y(j),:))';
        from=approximation(j+(i-1)*length(y),:);
        
        %fprintf('%i  %i \n',i,j);
        
        if (norm(to+from)<epsilon)
            mask(i,j)=1;
        end
        
    end
end


end


function res=bilinearInterpolation(data,point)

[n,m,~]=size(data);

low=floor(point);
low(low<1)=1;

high=ceil(point);

if (high(1)>n)
    high(1)=n;
end

if (high(2)>m)
    high(2)=m;
end

f_R1=(high(1)-point(1))/(high(1)-low(1))*squeeze(data(high(1),low(2),:))+...
    (point(1)-low(1))/(high(1)-low(1))*squeeze(data(low(1),low(2),:));

f_R2=(high(1)-point(1))/(high(1)-low(1))*squeeze(data(high(1),high(2),:))+...
    (point(1)-low(1))/(high(1)-low(1))*squeeze(data(low(1),high(2),:));


res=(high(2)-point(2))/(high(2)-low(2))*(f_R2)+(point(2)-low(2))/(high(2)-low(2))*(f_R1);


end
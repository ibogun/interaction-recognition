function [ optFlow ] = prepareOptFlow( optFlowLocation )
%PREPAREOPTFLOW Load optical flow for specific video into a stuct
%  
%
%   Input: 
%
%       optFlowLocation             -       directory with the optical flow
%           files
%
%   Output:
%   
%       optFlow                     -       data structure containing
%           optical flow
%
%   author: Ivan Bogun
%   date  : July 8, 2013

list=dir(optFlowLocation);
list=list(3:end);

%get the optical flow data
optFlow=struct('flow',[]);
optFlow=repmat(optFlow,length(list),1);

for ii=1:length(list)
    flow=load(strcat(optFlowLocation,'/',list(ii).name));
    flow=flow.F;
    optFlow(ii).flow=flow;
end

end


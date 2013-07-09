home=pwd;
addpath(home);
addpath(strcat(home,'/classes/'));
addpath(strcat(home,'/utilities/'));
addpath(strcat(home,'/localization/'));

run (strcat(home,'/utilities/cvx/cvx_setup.m'));
addpath_recurse('../ML toolbox/');
cd '..';
[pathstr,~,~]=fileparts('ML toolbox/');
MLhome=pwd;
addpath_recurse(strcat(MLhome,'/',pathstr));
cd 'interaction/';
clc;clear; close all;
% setup vl feat libraary
%run '/host/Users/ibogun2010/Libraries/vlfeat-0.9.16/toolbox/vl_setup.m';
%cd ('localization/');
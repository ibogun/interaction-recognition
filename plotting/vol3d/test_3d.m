

%% Example 1: display pollen grain slices 
clear all;

% read image sequence (resize images to one-half for fast processing)
fn = dir( 'pollen/slice*.png' );
N = size( fn, 1 );
for i = 1 :  N
    S( :, :, :, i )  = imresize( imread( [ 'pollen/' fn( i ).name ] ), .5 ); 
end

% save image volume into 3-d array 
MaxSlice = 17;
MinSlice = 5;
for i = MinSlice : MaxSlice 
    D( :, :, i )  = S(:,:,1,i); 
end

figure;
D = squeeze(D);
h = vol3d('cdata',D,'texture','2D');
view(3);  
axis tight;  
daspect([1 1 .05]);
alphamap('rampup');
alphamap(.3 .* alphamap);
set( gcf, 'Color', 'w' );




%% Example 2: display MRI data with 3-D interpolation (interframe). 
%   This example also uses a different scaling ratio for the depth
%   dimension. This ratio compress the slices together along the depth
%   dimension. 
clear all;

load mri.mat

figure;
D = squeeze(D);
h = vol3d('cdata',D,'texture','3D');
view(3);  
axis tight;  
daspect([1 1 .4]);
alphamap('rampup');
alphamap(.1 .* alphamap);
set( gcf, 'Color', 'w' );



%% Example 3: display a human action. Edge maps are used as frames. 
%   Using 3-D interpolation as in the mri sequence

%  Edge map of "bend" action
load bend_mach.mat

[ nrows, ncols, nframes ] = size( mach3d ); 

% display sequence as a montage
x = zeros( nrows, ncols, 1, nframes );
x(:,:,1,:) = mach3d;
figure, montage( mat2gray(x), 'Size', [6 10] ); colormap hot;
set( gcf, 'Color', 'w' );
title( 'Average Edge Map for 10 Sequences of Bend Action', 'FontSize', 15 );   

D = mach3d; 
figure;
D = squeeze(D);
h = vol3d('cdata',D,'texture','3D');
view(3);  
axis tight;  
daspect([1 1 .4]);
alphamap('rampup');
alphamap(.3 .* alphamap);
set( gcf, 'Color', 'w' );
title( 'Spatio-Temporal Volume for Bend Action', 'FontSize', 15 );   
colormap hot;



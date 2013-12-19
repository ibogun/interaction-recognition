
h = vol3d('cdata',P,'texture','3D');
view(3);  
axis tight;  
daspect([1 1 .3]);
alphamap('rampup');
alphamap(.3 .* alphamap);
set( gcf, 'Color', 'w' );
%title( 'Making a call', 'FontSize', 15 );   
colormap cool;
set(gca,'fontsize',20)
box on;
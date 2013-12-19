% load only once - takes lots of time


folder='tracking_probability_distribution/';

if (exist('trackingProbDistr','var')~=1)
    load ('trackingProbabilityDistribution');
end

for vid=1:54
    close all;
    P=trackingProbDistr{vid};
    
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
    
    if (vid<10)
        figureName=strcat(folder,'0',num2str(vid));
    else
        
        figureName=strcat(folder,num2str(vid));
    end
    
    saveas(gcf, figureName, 'fig');
    
end
%clc;clear; close all;


load ../../interpolatedFullDataInStruct;
%load trajectoriesCalculated;

total=0;
%localization=zeros(54,1);

for v=1:54
    
    clearvars t_c;
    % append with zeros because annotations start from the frame #3
    t_a=[zeros(2);data(v).trajectoryObject];
    t_calc=trajectory(v).trajectory;
    
    %    bestT=trajectory(v).bestT;
    
    tStart=data(v).tInteractionStart;
    tStop=data(v).tInteractionStop;
    
    t_c(:,2)=t_calc(:,1);
    t_c(:,1)=t_calc(:,2);
    t_c=t_c*2;
    trajectoriesObject{v}=t_c;
    %localization(v)=norm(t_a(bestT,:)-t_c(bestT,:));
    
    if (length(t_c)>length(t_a))
        
        t_c(end,:)=[];
    end
    
    if (length(t_c)>length(t_a))
        
        t_c(end,:)=[];
    end
    
    
    errFull(v)=norm(t_c(3:end)-t_a(3:end))/length(t_c);
    
    
    t_a=t_a(tStart:tStop,:);
    
    
    t_c=t_c(tStart:tStop,:);
    
    errLocalized(v)=norm(t_c-t_a)/length(t_c);
    
    
    total=total+errLocalized(v);
    fprintf('Current video %d, total norm sum: %f, localized error: %f\n',v,errFull(v),errLocalized(v));
end



total=total/54;
fprintf('Total Error %f \n',total);

for i=1:6
    idx=groundTruth==i;
    res=sum(errFull(idx))/sum(groundTruth==i);
    res1=sum(errLocalized(idx))/sum(groundTruth==i);
   fprintf('Current video %d, total norm sum: %f, localized error: %f\n',i,res,res1);
end

goodIdx=groundTruth~=5;

errFullsmall=errFull;
errLocalizedsmall=errLocalized;


close all;

h=figure;
plot(errFullsmall,'LineWidth', 2);
hold on;
plot(errLocalizedsmall,'Color','g','LineWidth', 2);

hold on;
xlabel('Video number','FontSize',30);
%ylabel('Pixel distance error, averaged per number of frames');

meanLocalized=mean(errLocalizedsmall);
meanFull=mean(errFullsmall);

lineWidth=2;
% Add a horizontal line for the Temperature at steady state
line('XData', [0 54], 'YData', [meanFull meanFull], 'LineStyle', '-', ...
    'LineWidth', lineWidth, 'Color','r');


% Add a horizontal line for the Temperature at steady state
line('XData', [0 54], 'YData', [meanLocalized meanLocalized], 'LineStyle', '-', ...
    'LineWidth', lineWidth, 'Color','r');
axis([1 54 0 33]);
set(gca,'fontsize',30)
%set(gca, 'renderer', 'opengl')
%fprintf('Localization Error %f \n',sum(localization)/54);
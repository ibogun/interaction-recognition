function [  ] = interactionMotionProfile( d,isSmoothed)
%INTERACTIONMOTIONPROFILE Plot motion profile for the interaction
%   Given interaction data structure the function will plot trajectories of
%   the hand/object, their velocities and accelerations.
%
%   Input:
%
%   d                   -           data structure containing the
%       intercation
%
%
%
%   author: Ivan Bogun

subplot(3,2,1);


hand=findMostCorrelated(d);


if (isSmoothed==1)
    gaus=gausswin(5);
    c=conv(hand(:,1),gaus);
    hand(:,1)=c(3:(end-2));
    c=conv(hand(:,2),gaus);
    hand(:,2)=c(3:(end-2));
end
partName=char(d.interactionName);

N=size(hand,1);

plot(1:N,hand(:,1),1:N,hand(:,2));

tGrasp=d.tGrasp;
tInteractionStart=d.tInteractionStart;
tInteractionStop=d.tInteractionStop;
tPutBack=d.tPutBack;

maxValue=max(max(hand(:)),abs(min(hand(:))));

title(strcat(partName,'/hand'),'FontSize',20);

line('XData', [tGrasp tGrasp], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');
xlabel('time frame','FontSize',20);
ylabel('coordinates','FontSize',20);
legend('x-projection','y-projection');

axis([0,N+5,-maxValue-10,maxValue+10]);

line('XData', [tInteractionStart tInteractionStart], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tInteractionStop tInteractionStop], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tPutBack tPutBack], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');




subplot(3,2,3);

velocity=hand(1:3:N,:);
velocity=diff(velocity);
t=2+1:3:N;

plot(t,velocity(:,1),t,velocity(:,2));

maxValue=max(max(velocity(:)),abs(min(velocity(:))));

title(strcat(partName,'/hand'),'FontSize',20);

line('XData', [tGrasp tGrasp], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');
xlabel('time frame','FontSize',20);
ylabel('velocities','FontSize',20);
legend('x-projection','y-projection');

axis([0,N+5,-maxValue-10,maxValue+10]);

line('XData', [tInteractionStart tInteractionStart], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tInteractionStop tInteractionStop], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tPutBack tPutBack], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');



subplot(3,2,5);

acceleration=diff(velocity);
t=2+2:3:(N-1);

plot(t,acceleration(:,1),t,acceleration(:,2));

maxValue=max(max(acceleration(:)),abs(min(acceleration(:))));

title(strcat(partName,'/hand'),'FontSize',20);

line('XData', [tGrasp tGrasp], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');
xlabel('time frame','FontSize',20);
ylabel('acceleration','FontSize',20);
legend('x-projection','y-projection');

axis([0,N+5,-maxValue-10,maxValue+10]);

line('XData', [tInteractionStart tInteractionStart], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tInteractionStop tInteractionStop], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tPutBack tPutBack], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');




subplot(3,2,2);


obj=d.trajectoryObject.singlePointArray;
if (isSmoothed==1)
    gaus=gausswin(5);
    c=conv(obj(:,1),gaus);
    obj(:,1)=c(3:(end-2));
    c=conv(obj(:,2),gaus);
    obj(:,2)=c(3:(end-2));
end
N=size(obj,1);

plot(1:N,obj(:,1),1:N,obj(:,2));

tGrasp=d.tGrasp;
tInteractionStart=d.tInteractionStart;
tInteractionStop=d.tInteractionStop;
tPutBack=d.tPutBack;

maxValue=max(max(obj(:)),abs(min(obj(:))));

title(strcat(partName,'/Object'),'FontSize',20);

line('XData', [tGrasp tGrasp], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');
xlabel('time frame','FontSize',20);
ylabel('coordinates','FontSize',20);
legend('x-projection','y-projection');

axis([0,N+5,-maxValue-10,maxValue+10]);

line('XData', [tInteractionStart tInteractionStart], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tInteractionStop tInteractionStop], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tPutBack tPutBack], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');




subplot(3,2,4);

velocity=obj(1:3:N,:);
velocity=diff(velocity);
t=2+1:3:N;

plot(t,velocity(:,1),t,velocity(:,2));

maxValue=max(max(velocity(:)),abs(min(velocity(:))));

title(strcat(partName,'/Object'),'FontSize',20);

line('XData', [tGrasp tGrasp], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');
xlabel('time frame','FontSize',20);
ylabel('velocities','FontSize',20);
legend('x-projection','y-projection');

axis([0,N+5,-maxValue-10,maxValue+10]);

line('XData', [tInteractionStart tInteractionStart], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tInteractionStop tInteractionStop], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tPutBack tPutBack], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');



subplot(3,2,6);

acceleration=diff(velocity);
t=2+2:3:(N-1);

plot(t,acceleration(:,1),t,acceleration(:,2));

maxValue=max(max(acceleration(:)),abs(min(acceleration(:))));

title(strcat(partName,'/Object'),'FontSize',20);

line('XData', [tGrasp tGrasp], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');
xlabel('time frame','FontSize',20);
ylabel('acceleration','FontSize',20);
legend('x-projection','y-projection');

axis([0,N+5,-maxValue-10,maxValue+10]);

line('XData', [tInteractionStart tInteractionStart], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tInteractionStop tInteractionStop], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

line('XData', [tPutBack tPutBack], 'YData', [-maxValue-10 maxValue+10], 'LineStyle', '-', ...
    'LineWidth', 2, 'Color','r');

end


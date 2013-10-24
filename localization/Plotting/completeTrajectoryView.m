clc;close all; clear;

%% load the data set
load('fullRawDataSet');



%% size of the data
N=length(data);

% number of the set of interactions
s=1;

% counter for each interaction
counters=zeros(6,1);

for i=1:N
    d=data(i);
    
    if (d.interactionName==interaction.drinking && counters(1,1)==0)
        counters(1,1)=i;
    end
    
    if (d.interactionName==interaction.lighting && counters(2,1)==0)
        counters(2,1)=i;
    end
    
    if (d.interactionName==interaction.pouring && counters(3,1)==0)
        counters(3,1)=i;
    end
    
    if (d.interactionName==interaction.spraying && counters(4,1)==0)
        counters(4,1)=i;
    end
    
    if (d.interactionName==interaction.talkingOnThePhone && counters(5,1)==0)
        counters(5,1)=i;
    end
    
    if (d.interactionName==interaction.talkingOnThePhoneAndDialing && counters(6,1)==0)
        counters(6,1)=i;
    end
    
end

subplot(3,2,1);
d=data(counters(1,1));

hand=findMostCorrelated(d);

N=size(hand,1);

plot(1:N,hand(:,1),1:N,hand(:,2));

tGrasp=d.tGrasp;
tInteractionStart=d.tInteractionStart;
tInteractionStop=d.tInteractionStop;
tPutBack=d.tPutBack;

maxValue=max(max(hand(:)),abs(min(hand(:))));

title('Drinking/Hand','FontSize',20);

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
t=2:3:N;

plot(t,velocity(:,1),t,velocity(:,2));

maxValue=max(max(velocity(:)),abs(min(velocity(:))));

title('Drinking/Hand','FontSize',20);

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
t=2:3:(N-3);

plot(t,acceleration(:,1),t,acceleration(:,2));

maxValue=max(max(acceleration(:)),abs(min(acceleration(:))));

title('Drinking/Hand','FontSize',20);

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
d=data(counters(1,1));

obj=d.trajectoryObject.singlePointArray;

N=size(obj,1);

plot(1:N,obj(:,1),1:N,obj(:,2));

tGrasp=d.tGrasp;
tInteractionStart=d.tInteractionStart;
tInteractionStop=d.tInteractionStop;
tPutBack=d.tPutBack;

maxValue=max(max(obj(:)),abs(min(obj(:))));

title('Drinking/Object','FontSize',20);

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
t=2:3:N;

plot(t,velocity(:,1),t,velocity(:,2));

maxValue=max(max(velocity(:)),abs(min(velocity(:))));

title('Drinking/Object','FontSize',20);

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
t=2:3:(N-3);

plot(t,acceleration(:,1),t,acceleration(:,2));

maxValue=max(max(acceleration(:)),abs(min(acceleration(:))));

title('Drinking/Object','FontSize',20);

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




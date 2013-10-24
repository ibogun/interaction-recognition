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
d=data(counters(4,1));

obj=findMostCorrelated(d);

N=size(obj,1);

plot(1:N,obj(:,1),1:N,obj(:,2));

tGrasp=d.tGrasp;
tInteractionStart=d.tInteractionStart;
tInteractionStop=d.tInteractionStop;
tPutBack=d.tPutBack;

maxValue=max(max(obj(:)),abs(min(obj(:))));

title('Spraying','FontSize',20);

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




subplot(3,2,2);

difference=obj(1:3:N,:);
difference=diff(difference);
t=2:3:N;

plot(t,difference(:,1),t,difference(:,2));

maxValue=max(max(difference(:)),abs(min(difference(:))));

title('Spraying','FontSize',20);

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





d=data(counters(5,1));
subplot(3,2,3);
obj=findMostCorrelated(d);


N=size(obj,1);

plot(1:N,obj(:,1),1:N,obj(:,2));

tGrasp=d.tGrasp;
tInteractionStart=d.tInteractionStart;
tInteractionStop=d.tInteractionStop;
tPutBack=d.tPutBack;

maxValue=max(max(obj(:)),abs(min(obj(:))));

title('Talking On The Phone','FontSize',20);

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

difference=obj(1:3:N,:);
difference=diff(difference);
t=2:3:N;

plot(t,difference(:,1),t,difference(:,2));

maxValue=max(max(difference(:)),abs(min(difference(:))));

title('Talking On The Phone','FontSize',20);

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






d=data(counters(6,1));
subplot(3,2,5);
obj=findMostCorrelated(d);


N=size(obj,1);

plot(1:N,obj(:,1),1:N,obj(:,2));

tGrasp=d.tGrasp;
tInteractionStart=d.tInteractionStart;
tInteractionStop=d.tInteractionStop;
tPutBack=d.tPutBack;

maxValue=max(max(obj(:)),abs(min(obj(:))));

title('Talking On The Phone and Dialing','FontSize',20);

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



subplot(3,2,6);

difference=obj(1:3:N,:);
difference=diff(difference);
t=2:3:N;

plot(t,difference(:,1),t,difference(:,2));

maxValue=max(max(difference(:)),abs(min(difference(:))));

title('Talking On The Phone and Dialing','FontSize',20);

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
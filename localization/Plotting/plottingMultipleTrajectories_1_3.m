clc;close all; clear;

%% load the data set
load('fullRawDataSet');



%% size of the data
N=length(data);

% counter for each interaction
n=5;
indices=zeros(6,n);

counters=ones(6,1);

for i=1:N
    d=data(i);
    
    
    
    if (d.interactionName==interaction.drinking)
        
        if (counters(1,1)>n)
            continue;
        end
        
        indices(1,counters(1,1))=i;
        counters(1,1)=counters(1,1)+1;
    end
    
    if (d.interactionName==interaction.lighting)
        
        if (counters(2,1)>n)
            continue;
        end
        
        indices(2,counters(2,1))=i;
        counters(2,1)=counters(2,1)+1;
    end
    
    
    if (d.interactionName==interaction.pouring)
        
        if (counters(3,1)>n)
            continue;
        end
        
        indices(3,counters(3,1))=i;
        counters(3,1)=counters(3,1)+1;
    end
    
    if (d.interactionName==interaction.spraying)
        
        if (counters(4,1)>n)
            continue;
        end
        
        indices(4,counters(4,1))=i;
        counters(4,1)=counters(4,1)+1;
    end
    
    if (d.interactionName==interaction.talkingOnThePhone)
        
        if (counters(5,1)>n)
            continue;
        end
        
        indices(5,counters(5,1))=i;
        counters(5,1)=counters(5,1)+1;
    end
    
    if (d.interactionName==interaction.talkingOnThePhoneAndDialing)
        
        if (counters(6,1)>n)
            continue;
        end
        
        indices(6,counters(6,1))=i;
        counters(6,1)=counters(6,1)+1;
    end
    
    
    
end

subplot(3,2,1);

d=data(indices(1,1));
obj=findMostCorrelated(d);

N=size(obj,1);


plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'b');
hold on;

d=data(indices(1,2));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'g');

hold on;

d=data(indices(1,3));
obj=findMostCorrelated(d);

N=size(obj,1);
plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'m');
%plot(1:N,obj(:,1),'m');

hold on;

d=data(indices(1,4));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'r');

hold on;

d=data(indices(1,5));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'c');
title('Drinking','FontSize',20);

xlabel('time frame','FontSize',20);
ylabel('x-position','FontSize',20);
legend(num2str(indices(1,1)),num2str(indices(1,2)),num2str(indices(1,3)),num2str(indices(1,4)),num2str(indices(1,5)));

subplot(3,2,2);

d=data(indices(1,1));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'b');

hold on;

d=data(indices(1,2));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'g');

hold on;

d=data(indices(1,3));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'m');

hold on;

d=data(indices(1,4));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'r');

hold on;

d=data(indices(1,5));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'c');
title('Drinking','FontSize',20);

xlabel('time frame','FontSize',20);
ylabel('y-position','FontSize',20);

legend(num2str(indices(1,1)),num2str(indices(1,2)),num2str(indices(1,3)),num2str(indices(1,4)),num2str(indices(1,5)));

%% second raw of the plot

subplot(3,2,3);

d=data(indices(2,1));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'b');

hold on;

d=data(indices(2,2));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'g');

hold on;

d=data(indices(2,3));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'m');

hold on;

d=data(indices(2,4));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'r');

hold on;

d=data(indices(2,5));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'c');
title('Lighting','FontSize',20);

xlabel('time frame','FontSize',20);
ylabel('x-position','FontSize',20);
legend(num2str(indices(2,1)),num2str(indices(2,2)),num2str(indices(2,3)),num2str(indices(2,4)),num2str(indices(2,5)));

subplot(3,2,4);

d=data(indices(2,1));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'b');

hold on;

d=data(indices(2,2));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'g');

hold on;

d=data(indices(2,3));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'m');

hold on;

d=data(indices(2,4));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'r');

hold on;

d=data(indices(2,5));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'c');
title('Lighting','FontSize',20);

xlabel('time frame','FontSize',20);
ylabel('y-position','FontSize',20);

legend(num2str(indices(2,1)),num2str(indices(2,2)),num2str(indices(2,3)),num2str(indices(2,4)),num2str(indices(2,5)));


%% third raw of the plot

subplot(3,2,5);

d=data(indices(3,1));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'b');

hold on;

d=data(indices(3,2));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'g');

hold on;

d=data(indices(3,3));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'m');

hold on;

d=data(indices(3,4));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'r');

hold on;

d=data(indices(3,5));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,1),'c');
title('Pouring','FontSize',20);

xlabel('time frame','FontSize',20);
ylabel('x-position','FontSize',20);
legend(num2str(indices(3,1)),num2str(indices(3,2)),num2str(indices(3,3)),num2str(indices(3,4)),num2str(indices(3,5)));

subplot(3,2,6);

d=data(indices(3,1));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'b');

hold on;

d=data(indices(3,2));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'g');

hold on;

d=data(indices(3,3));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'m');

hold on;

d=data(indices(3,4));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'r');

hold on;

d=data(indices(3,5));
obj=findMostCorrelated(d);

N=size(obj,1);

plot(d.tInteractionStart:d.tInteractionStop,obj(d.tInteractionStart:d.tInteractionStop,2),'c');
title('Pouring','FontSize',20);

xlabel('time frame','FontSize',20);
ylabel('y-position','FontSize',20);

legend(num2str(indices(3,1)),num2str(indices(3,2)),num2str(indices(3,3)),num2str(indices(3,4)),num2str(indices(3,5)));

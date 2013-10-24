clc;clear;close all;

load('fullRawDataSet');


over=0;
under=0;

threshold=30;

within=0;


for i=1:54
    [f,l]=localizeInteraction(data(i));
    
    start=data(i).tInteractionStart;
    stop=data(i).tInteractionStop;
    
    if (f>stop)
        over=over+1;
    end
    if (l<start)
        under=under+1;
    end
    
    if (abs(start-f)<threshold && abs(stop-l)<threshold)
        within=within+1;
    end
    
end

display(over);
display(under);
display(within);














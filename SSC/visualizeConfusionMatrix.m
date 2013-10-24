function [  ] = visualizeConfusionMatrix( mat )
%VIUALIZECONFUSIONMATRIX Plot confusion matrix
%   
%   Author:         I.Bogun (ibogun2010@my.fit.edu)
%   Date  :         03/07/2013

imagesc(mat);            %# Create a colored plot of the matrix values
colormap(flipud(gray));  %# Change the colormap to gray (so higher values are
                         %#   black and lower values are white)
set(0,'DefaultTextInterpreter', 'latex')
set(0,'DefaultTextFontSize',32);                         
textStrings = num2str(mat(:),'%2g');  %# Create strings from the matrix values
textStrings = strtrim(cellstr(textStrings));  %# Remove any space padding
[x,y] = meshgrid(1:6);   %# Create x and y coordinates for the strings
hStrings = text(x(:),y(:),textStrings(:),...      %# Plot the strings
                'HorizontalAlignment','center');
midValue = mean(get(gca,'CLim'));  %# Get the middle value of the color range
textColors = repmat(mat(:) > midValue,1,3);  %# Choose white or black for the
                                             %#   text color of the strings so
                                             %#   they can be easily seen over
                                             %#   the background color
set(hStrings,{'Color'},num2cell(textColors,2));  %# Change the text colors

set(gca,'XTick',1:6,...                         %# Change the axes tick marks
        'XTickLabel',{'drinking','lighting','pouring','spraying','talking','dialing'},...  %#   and tick labels
        'YTick',1:6,...
        'YTickLabel',{'drinking','lighting','pouring','spraying','talking','dialing'},...
        'TickLength',[0 0]);
    
labels={'drinking','lighting','pouring','spraying','talking','dialing'};

%% Generate figure and remove ticklabels

set(gca,'yticklabel',[], 'xticklabel', []) %Remove tick labels

%% Get tick mark positions
yTicks = get(gca,'yTick');
xTicks = get(gca, 'xTick');

ax = axis; %Get left most x-position
HorizontalOffset = 0.1;

%% Reset the ytick labels in desired font
for i = 1:length(labels)
%Create text box and set appropriate properties
text(ax(1) - HorizontalOffset,yTicks(i),['$' labels{i} '$'],...
'HorizontalAlignment','Right','interpreter', 'latex'); 
end

%% Reset the xtick labels in desired font 
minY = max(yTicks);
verticalOffset = 0.2;

for xx = 1:length(labels)
%Create text box and set appropriate properties
text(xTicks(xx)+0.25, minY + verticalOffset+0.55, ['$' labels{xx} '$'],...
'HorizontalAlignment','Right','interpreter', 'latex'); 
end

title('Target/predicted confusion matrix')
h = get(gca, 'title');
set(h, 'FontName', 'latex','fontsize',32)
%# make all text in the figure to size 14 and bold
%set(findall(figureHandle,'type','text'),'fontSize',14,'fontWeight','bold')
% set(0,'DefaultAxesFontName', 'Times New Roman')
% set(0,'DefaultAxesFontSize', 32)
% 
% % Change default text fonts.
% set(0,'DefaultTextFontname', 'Times New Roman')
% set(0,'DefaultTextFontSize',32)
end


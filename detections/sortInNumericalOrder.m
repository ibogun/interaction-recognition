function [ sortedfiles ] = sortInNumericalOrder( path )
%SORTINNUMERICALORDER Summary of this function goes here
%   Detailed explanation goes here
files=dir(path);
files=files(3:end);
numfiles = size(files,1); % Find number of files
numdelim = 1; % Number of delimiters
delims = ['BB_f' '.']; % Delimiters used

% Create a matrix of the file list index and the delimiters
filenums=[ [1:numfiles]' zeros(numfiles,numdelim) ];
for i=1:numfiles % Cycles through list of files
rem=files(i).name;
for j=1:numdelim % Cycles through the filename delimiters
[token,rem] = strtok(rem,delims);
filenums(i,j+1) = str2num(token);
end
end

% Sort the matrix by rows
filenums = sortrows(filenums,[2:numdelim+1]);


% Create a cell array of the filenames in new order
for i=1:numfiles
sortedfiles{i,1} = files(filenums(i,1)).name;
end

end


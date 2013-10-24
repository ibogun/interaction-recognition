function [ detections,correctIndices] = sortDetections( detections )
%SORTDETECTIONS Function will sort detections 

pat={'\d'};
indices=1:length(detections);

for i=1:length(detections)
    name=detections(i).name;
    position=regexp(name,pat);
    position=position{1};
    
    intPosition=str2num(name(position));
    indices(i)=intPosition;
end

[~,correctIndices]=sort(indices);

detections=detections(correctIndices);

end


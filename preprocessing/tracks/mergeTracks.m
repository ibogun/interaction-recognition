function [ mergedTracks ] = mergeTracks( tracks, epsilon )
%MERGETRACKS Summary of this function goes here
%   Detailed explanation goes here






n=length(tracks);
matrixTracks=tracksToMatrix(tracks);
c=0;
negativeTracks=[];
for i=1:n
    var=matrixTracks(i,:,:);
    var=squeeze(var);
    var=var(:);
    if ((any(var<1))==1)
        c=c+1;
        negativeTracks(c)=i;
    end
end

tracks(negativeTracks)=[];

n=length(tracks);
counter=0;

labels=zeros(n,1);

for i=1:n
    
    if (labels(i)~=0)
        continue;
    end
    counter=counter+1;
    trackVar=tracks(i).track;
    labels(i)=counter;
    
    % find all unlabeled tracks
    indices=find(labels==0);
    unlabaledTracks=tracks(indices);
    
    m=length(unlabaledTracks);
    
    for j=1:m
        if (max(abs(trackVar-tracks(indices(j)).track))<epsilon)
            labels( indices(j))=counter;
        end
    end
end

matrixTracks=tracksToMatrix(tracks);
[~,m,k]=size(matrixTracks);
mergedTracks=zeros(counter,m,k);

for i=1:counter
    similarTracks=matrixTracks(find(labels==i),:,:);
    mergedTracks(i,:,:)=mean(similarTracks,1);
end

end



function matrixTracks=tracksToMatrix(tracks)

n=length(tracks);
[m,k]=size(tracks(1).track);
matrixTracks=zeros(n,m,k);
for i=1:n
    matrixTracks(i,:,:)=tracks(i).track;
end

end
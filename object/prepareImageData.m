
videoNames='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames/';
videos=dir(videoNames);
videos=videos(3:end);


%clearvars videoNames;

for i=1:length(videos)
    fullVideoNames{i}=strcat(videoNames,videos(i).name);
end

for i=1:length(videos)
   
    images=dir(fullVideoNames{i});
    images=images(3:end);
    
    n=length(images);
    
    for j=1:n
       vid{j}=imread(strcat(fullVideoNames{i},'/',images(j).name)); 
    end
    
end
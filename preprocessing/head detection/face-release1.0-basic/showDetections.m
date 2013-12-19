


videosFolder='/media/ibogun2010/OS/Users/ibogun2010/Documents/datasets/Gupta/frames';

videoNames=dir(videosFolder);
videoNames=videoNames(3:end);


for i=1:length(videoNames)
    video{i}=strcat(videosFolder,'/',videoNames(i).name,'/');
end


vid=17;


detections=headDetectedTrajectories{vid};
detections=detections';

files=dir(video{vid});
files=files(3:end);

for i=1:length(files)
    
    %
    
    if (detections(1,i)~=0)
        fileNames=strcat(video{vid},'/',files(i).name);
        imshow(fileNames);
        hold on;
        plot(detections(1,i),detections(2,i),'b*');
        pause(1);
    end
    
end
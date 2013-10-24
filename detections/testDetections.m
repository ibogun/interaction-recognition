sourceImages='/host/Users/ibogun2010/datasets/Gupta/frames/';
load('interpolatedFullDataInStruct');
listVideos=dir(sourceImages);
listVideos=listVideos(3:end);


detectionSource='/host/Users/ibogun2010/datasets/Gupta/detections/hand detections/';
listDetections=dir(detectionSource);
listDetections=listDetections(3:end);

% iterate through every video
i=1;

imageFilename=strcat(sourceImages,listVideos(i).name);

% example : /host/Users/ibogun2010/datasets/Gupta/detections/hand detections/c01
imagesFolder=strcat(sourceImages,listVideos(i).name);
detectionFilename=strcat(detectionSource,listDetections(i).name);

images=dir(imagesFolder);
images=images(3:end);

detections=sortInNumericalOrder(detectionFilename);
%detections=detections(3:end);

n=length(images);


% iterate through every image in the video
for j=1:length(detections)
    
    image=imread(strcat(imagesFolder,'/',images(j).name));
    detectionFrom=load(strcat(detectionFilename,'/',detections{j}));
    detectionFrom=detectionFrom.BB;
    d=round(detectionFrom(:,1:4));
    
    showDetection(image,d,size(detectionFrom,1));
    pause;
end
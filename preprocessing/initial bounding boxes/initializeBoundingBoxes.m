folder='/host/Users/ibogun2010/datasets/Gupta/frames/';

videos=dir(folder);
videos=videos(3:end);

%boxes=zeros(54,5);
for i=52:length(videos)
    vidName=strcat(folder,videos(i).name);
    images=dir(vidName);
    images=images(3:end);
    
    num=round(length(images)/2)-2;
    
    I=imread(strcat(vidName,'/',images(num).name));
    imshow(I);
    pause;
    
    hand=input('Which hand 1-left, 2-right? \n');
    
    close;
    I=imread(strcat(vidName,'/',images(1).name));
    imshow(I);
    bb=ginput(2);
    bb=[bb(1) bb(3) bb(2) bb(4) hand];
    close;
    boxes(i,:)=bb;
end
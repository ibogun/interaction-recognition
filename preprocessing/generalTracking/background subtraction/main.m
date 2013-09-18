% sizes of the image
m=480;
n=640;

load('L+S');

nFrames=size(SS_0,2);


for i=1:nFrames
    filename='images/sparseFirstImage';
    I=SS_0(:,i);
    I=reshape(I,m/2,n/2);
    I=imresize(I,2);
    im=uint8(I);
    
    if (i<10)
        filename=strcat(filename,'0',num2str(i),'.jpg');
    else
        filename=strcat(filename,num2str(i),'.jpg');
    end
    imwrite(im,filename);
end
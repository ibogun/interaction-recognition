close all;


threshold=7;

id=7;

close all;

%fprintf('Current video: %d \n',id);
s=getSparseData(id);

[bestX,bestY,bestT]=findBestLocation(s,threshold);

% plotting

video=getImageData(id);
showLocations(s,video,bestX,bestY,bestT);




I=rgb2gray(video{1});
%imshow(I)

hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(I), hy, 'replicate');
Ix = imfilter(double(I), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);
%figure, imshow(gradmag,[]), title('Gradient magnitude (gradmag)')

L = watershed(gradmag);
Lrgb = label2rgb(L);
%figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)')

se = strel('disk', 20);
Io = imopen(I, se);
%figure, imshow(Io), title('Opening (Io)')


Ie = imerode(I, se);
Iobr = imreconstruct(Ie, I);
%figure, imshow(Iobr), title('Opening-by-reconstruction (Iobr)')


Ioc = imclose(Io, se);
%figure, imshow(Ioc), title('Opening-closing (Ioc)')


Iobrd = imdilate(Iobr, se);
Iobrcbr = imreconstruct(imcomplement(Iobrd), imcomplement(Iobr));
Iobrcbr = imcomplement(Iobrcbr);
%figure, imshow(Iobrcbr), title('Opening-closing by reconstruction (Iobrcbr)')

hy = fspecial('sobel');
hx = hy';
Iy = imfilter(double(Iobrcbr), hy, 'replicate');
Ix = imfilter(double(Iobrcbr), hx, 'replicate');
gradmag = sqrt(Ix.^2 + Iy.^2);

L = watershed(gradmag);
Lrgb = label2rgb(L);
figure, imshow(Lrgb), title('Watershed transform of gradient magnitude (Lrgb)')

hold on;
plot(bestX*2,(bestY-10)*2,'r*');

% fgm = imregionalmax(Iobrcbr);
% figure, imshow(fgm), title('Regional maxima of opening-closing by reconstruction (fgm)')

%
% I2 = I;
% I2(fgm) = 255;
% figure, imshow(I2), title('Regional maxima superimposed on original image (I2)')
%
%
% se2 = strel(ones(5,5));
% fgm2 = imclose(fgm, se2);
% fgm3 = imerode(fgm2, se2);
%
%
% fgm4 = bwareaopen(fgm3, 20);
% I3 = I;
% I3(fgm4) = 255;
% figure, imshow(I3)
% title('Modified regional maxima superimposed on original image (fgm4)')

%
% bw = im2bw(Iobrcbr, graythresh(Iobrcbr));
% figure, imshow(bw), title('Thresholded opening-closing by reconstruction (bw)')
%
%
% D = bwdist(bw);
% DL = watershed(D);
% bgm = DL == 0;
% figure, imshow(bgm), title('Watershed ridge lines (bgm)')
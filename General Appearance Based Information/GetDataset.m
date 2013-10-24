function [objects, didFramesExceedDataset] = GetDataset( datasetFolder, locationOfImages, numberOfFrames, Xsize, Ysize)
%GetDataset
%   - currently hardcoded to get the frames when the flashlight turns ON
%   - give it the folder of the entire dataset
%   - objects will be a structure where each entry is the image.
%   - numberOfFrames is number of pictures of Objects for each folder in
%   the dataset
%   - starting Frame is the frame for which to start extracting the image,
%   it is an array that corresponds to each image

%get the directories in the dataset folder
    directories = dir(datasetFolder);
    
    didFramesExceedDataset = false;
    
    index = 1;
    %get the names of the folders with the dataset
    for i = 1 : length(directories)
        if(isempty(findstr(directories(i).name, '.')))
            datasets{index} = [directories(i).name];
            index = index + 1;
        end
    end

    datasets = datasets';
    numberOfVideos = length(locationOfImages);
    %start matching each dataset to its corresponding trajectories

    Xspace = Xsize;
    Yspace = Ysize;

    %   store all  objects in this cell
    objects = cell(1, length(locationOfImages));
     %try
            for datasetNumber = 1 : numberOfVideos
                objectImages = cell(1, numberOfFrames);
                startingFrame = 1;
                for frames = 0 : numberOfFrames - 1
                    %assume that the object can be located at the given starting frame
                    currentFrame = startingFrame + frames;
                    imgData = strcat(datasetFolder, '/', datasets{datasetNumber}, '/', num2str(currentFrame, '%03d'), '.ppm');
                    img = (imread(imgData));
                    %figure('name','Frame');
%                     figure(1);
%                     image(img);
%                     title('Frame');
                    %trajectory vector for each
                    %traj = processedData(datasetNumber).trajectoryObject.singlePointArray;
                    traj = locationOfImages{datasetNumber};
                    %multiply image by a mask to get the object
                    originOfObject = traj(currentFrame,:); %originofObject(1) is X direction, originOfObject(2) is Y direction
                    imageMask = uint8(zeros(size(img,1), size(img,2), size(img,3)));
                    %imageMask(originOfObject(1) - 15 : originOfObject(1) + 35, originOfObject(2) - 30 : originOfObject(2) + 20, : )  = 1;
                    %size(img(1)) is y direction, size(img(2)) is x direction
                    %originofObject(1) is X direction, originOfObject(2) is Y direction
                    if(originOfObject(1) + Xspace > size(img,2))
                        Xspace = size(img,2) - originOfObject(1);
                    elseif(originOfObject(2) + Yspace > size(img,1))
                        Yspace = size(img,1) - originOfObject(2);
                    else
                        Xspace = Xsize;
                        Yspace = Ysize;
                    end
                    originOfObject(2) = fix(originOfObject(2)); Yspace = fix(Yspace); originOfObject(1) = fix(originOfObject(1)); Xspace = fix(Xspace);
                    %imageMask (Ydirection, Xdirection,:)
                    imageMask(originOfObject(2) - Yspace : originOfObject(2) + Yspace, originOfObject(1) - Xspace : originOfObject(1) + Xspace, : )  = 1;
                    objectImage = imageMask .* img;
                    %objectImage = objectImage(originOfObject(1) - 15 : originOfObject(1) + 35, originOfObject(2) - 30 : originOfObject(2) + 20, : );
                    objectImage = objectImage(originOfObject(2) - Yspace : originOfObject(2) + Yspace, originOfObject(1) - Xspace : originOfObject(1) + Xspace, : );
                    %figure('name', 'Object');
%                     figure(2);
%                     image(objectImage);
                    %store all object images pertaining to the dataset folder here
                    objectImages{frames+1} = objectImage;
                end
                objects{datasetNumber} = objectImages;
            end
%     catch err
%         disp('numberOfFrames Exceeded the Dataset');
%         didFramesExceedDataset = true;
%         return;
%     end
end


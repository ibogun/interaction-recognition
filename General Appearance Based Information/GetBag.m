function [ videos ] = GetBag(data, numberOfClusters, videoSizes, mode)
%GetBag will return a cell array whose cells correspond to a class and
%the vector contained in the cell array correspond to the labels assigned
%to that class
    
    videos = cell(1, length(videoSizes));
    
    options = statset('MaxIter', 200);

    if(nargin == 4)
        if(strcmp(mode, 'SPAM'))
            %   SPARSE mode
            cd ./spams-matlab;
            start_spams;
            data = data';
            param.K = numberOfClusters;
            param.lambda = .15;
            param.iter = 1000;
            dictionary = mexTrainDL(data,param);
            cd ../;
            
            labels = zeros(1, size(data, 2));
            for datavector = 1 : size(data, 2)
                distance = zeros(1, size(dictionary, 2));
                for centroid = 1 : size(dictionary, 2)
                    distance(centroid) = norm(data(:, datavector) - dictionary(:, centroid));
                end
                [~, labels(datavector)] = min(distance); 
            end
        end
    else
        [IDX, C, sumd] = kmeans(double(data), numberOfClusters, 'Replicates', 5, 'Options', options);
        labels = IDX;
    end
    for video = 1 : length(videoSizes)
        videos{video} = labels(1 : videoSizes(video));
        labels = labels(videoSizes(video) + 1 : end);
    end

end

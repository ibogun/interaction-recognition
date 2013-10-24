function [combinedPatches, combinedDoubletPatches, groundTruth] = GetGeneralPatches(objectImages, patchSize, isCanninized, isDoublets, topics)
%GetGeneralPatches grabs the patches of the image according to the
%patchSize
%   combinedDoubletPatches will only get doublet patches if isDoublets is
%   true;
    
    categories = cell(length(topics), 1);
    for topic = 1 : length(topics)
        categories{topic} = [topics{topic} 'Patches'];
    end
    
    if(~isDoublets)
        combinedDoubletPatches = [];
    end
    
    for topic = 1 : length(topics)
        for video = 1 : length(objectImages.(topics{topic}).video)
            
            videoPatches = []; videoDoubletPatches = [];
            for frame =  1 : length(objectImages.(topics{topic}).video{video})
                if(~isCanninized)
                    objectImages.(topics{topic}).video{video}{frame} = rgb2gray(objectImages.(topics{topic}).video{video}{frame});
                end
                numberOfTimesColumnsDivisible = fix(size(objectImages.(topics{topic}).video{video}{frame}, 2) / patchSize);
                numberOfTimesRowsDivisible = fix(size(objectImages.(topics{topic}).video{video}{frame}, 1) / patchSize);
                shavedMatrix = objectImages.(topics{topic}).video{video}{frame}(1 : numberOfTimesRowsDivisible * patchSize, 1 : numberOfTimesColumnsDivisible * patchSize);
                rows = patchSize * ones(1, numberOfTimesRowsDivisible); cols = patchSize * ones(1, numberOfTimesColumnsDivisible);
                c = mat2cell(shavedMatrix, rows, cols);
                if(isDoublets)
                    [patches, doubletPatches] = GetPatchesForImage(c, patchSize, isDoublets);
                    videoDoubletPatches = [videoDoubletPatches doubletPatches];
                else
                    patches = GetPatchesForImage(c, patchSize, isDoublets);
                end
                videoPatches = [videoPatches patches];
            end
            if(isDoublets)
                combinedDoubletPatches.(categories{topic}){video} = videoDoubletPatches;
            end
            combinedPatches.(categories{topic}){video} = videoPatches;
        end
        
    end
    
    groundTruth = [];    
    for topic = 1 : length(topics)
        key.topics{topic} = topic;
        groundTruth = [groundTruth; topic * ones(size(combinedPatches.(categories{topic}),2), 1)];
    end
    
    combinedPatches.allPatches = CombinePatches(combinedPatches, categories)';
    if(isDoublets)
        combinedDoubletPatches.allPatches = CombinePatches(combinedDoubletPatches, categories)';
    end
    
end

function [singlePatches, doubletPatches] = GetPatchesForImage(c, patchSize, isDoublets)
    singlePatches = zeros(patchSize * patchSize, size(c,1) * size(c,2));
    
    for row = 1 : size(c, 1)
        for col = 1 : size(c, 2)
            c{row,col} = reshape(c{row,col}, patchSize * patchSize, 1);            
        end
    end
    
    %single patches
    for patch = 1 : size(singlePatches, 2)
        singlePatches(:, patch) = c{patch};
    end
    
    %if doublets were selected
    if(isDoublets)
        % doubletPatches = zeros(patchSize * patchSize, size(c, 1) * (size(c, 2) - 1) + size(c,2) * (size(c, 1) - 1));
        doubletPatches = [];
        for rowDoublet = 1 : size(c, 1)
            for col = 1 : size(c, 2) - 1
                zealot = [c{rowDoublet, col} c{rowDoublet, col+1}];
                doubletPatches = [doubletPatches zealot];
            end
        end
        for colDoublet = 1 : size(c, 2)
            for row = 1 : size(c, 1) - 1
                dragoon = [c{row, colDoublet} c{row + 1, colDoublet}];
                doubletPatches = [doubletPatches dragoon];
            end
        end
    end
end

function [templar] = CombinePatches(combinedPatches, categories)
    templar = []; combined = [];
    for category = 1 : length(categories)
        combined = [combined combinedPatches.(categories{category})];
    end
    
    for video = 1 : size(combined, 2)
        templar = [templar combined{video}];
    end
end
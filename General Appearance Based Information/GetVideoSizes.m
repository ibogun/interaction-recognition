function [videoSizes] = GetVideoSizes(combinedPatches, topics)

    categories = cell(length(topics), 1);
    for topic = 1 : length(topics)
        categories{topic} = [topics{topic} 'Patches'];
    end
    
    videoSizes = [];
    for category = 1 : length(categories)
        for video = 1 : length(combinedPatches.(categories{category}))
            videoSizes = [videoSizes size(combinedPatches.(categories{category}){video}, 2)];
        end
    end
end

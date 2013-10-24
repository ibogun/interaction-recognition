function [ cannyObjectImages ] = CanninizeObjectImages( objectImages, categories)
%run canny method on all the objects

    for topic = 1 : length(categories)
        for video = 1 : length(objectImages.(categories{topic}).video)
            for frame = 1 : length(objectImages.(categories{topic}).video{video})
                [~, cannyObjectImages.(categories{topic}).video{video}{frame}] = canny(objectImages.(categories{topic}).video{video}{frame}, 5, 1, .1);
            end
        end
    end

end


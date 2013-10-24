function [objectImages, order] = DisplayObjectImages(objects, categories, order)
%   provide the categories in cell array of strings
    if(nargin < 3)
        figure(1);
        order = zeros(length(objects), 1);
        numberOfCategories = length(categories);
        key = 'key: '; structures = '';
        for category = 1 : numberOfCategories
            categories{category} = categories{category}(~isspace(categories{category}));
            key = [key categories{category} ' = ' num2str(category) ', '];
            structures = [structures '''' categories{category} '''' ',[], '];
        end
        key = [key(1 : length(key)-2) ': '];
        structures = structures(1: length(structures) - 2);
        objectImages = eval(['struct(' structures ')']);
        for category = 1 : numberOfCategories
            eval(['objectImages.' categories{category} '.video = cell(0, 0);']);
        end
        for object = 1 : length(objects)
            image(objects{object}{1});
            index = input(key);
            objectImages.(categories{index}).video{length(objectImages.(categories{index}).video) + 1} = objects{object};
            order(object) = index;
        end
    elseif(size(order) > 0)
        numberOfCategories = length(categories);
        for category = 1 : numberOfCategories
            categories{category} = categories{category}(~isspace(categories{category}));
            structures = [structures '''' categories{category} '''' ',[], '];
        end
        structures = structures(1: length(structures) - 2);
        objectImages = eval(['struct(' structures ')']);
        for category = 1 : numberOfCategories
            eval(['objectImages.' categories{category} '.video = cell(0, 0);']);
        end
        for object = 1 : length(objects)
            objectImages.(categories{order(object)}).video{length(objectImages.(categories{order(object)}).video) + 1} = objects{object};
        end
    end
end
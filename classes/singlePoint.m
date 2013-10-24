classdef singlePoint
    %BOUNDINGBOX Class to store a point of the trajectory
    %   
    %   Author:         I.Bogun (ibogun2010@my.fit.edu)
    %   Date  :         03/07/2013
    properties
        point;
    end
    
    methods
        function obj=singlePoint(dataMatrix)
            % dataMatrix - the one from gnput
            if (nargin>0)
                try
                    obj.point=dataMatrix(1,:);
                    
                catch err
                    display('Wrong input, the input should be 4x2 matrix');
                    rethrow(err);
                end
            end
        end
        
        % getter method
        function point = getPoint(obj)
            point = obj.point;
        end
        
    end
end


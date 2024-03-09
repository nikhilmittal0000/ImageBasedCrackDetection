function averageWidth = calculateCrackWidth(filteredcc, imsize)
    averageWidth = [];
    for i = 1:filteredcc.NumObjects
        width = [];
        obj = filteredcc.PixelIdxList{i};
        random_points = randperm(size(obj,1),10);
        obj_random = obj(random_points,1);
        for j = 1:size(obj_random,1)
            coor = getCoordinates(obj_random(j), imsize);
            width1 = getWidthInDir(obj, coor, 'E-W', imsize);
            width2 = getWidthInDir(obj, coor, 'N-S', imsize);
            width = [width width1*width2/sqrt(width1^2 + width2^2)];
        end
        averageWidth = [averageWidth mean(width)];
    end
end
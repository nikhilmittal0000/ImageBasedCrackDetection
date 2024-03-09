function [crackConnections, bbox_final] = detectCracks(I_binarized, pixel_threshold, bounding_box_threshold)
    imsize = size(I_binarized);
    cc = bwconncomp(I_binarized);
    crackConnections = cc;
    crackConnections.PixelIdxList = {};
    bbox_final = [];
    for i = 1:cc.NumObjects
        obj = cc.PixelIdxList{i};
        if size(obj,1) > pixel_threshold
            bbox = getBoundingBox(obj, imsize(1));
            if sqrt(bbox(3)^2 + bbox(4)^2)> bounding_box_threshold
                bbox_final(end+1,:) = bbox;
                crackConnections.PixelIdxList{end+1,1} = cc.PixelIdxList{i};
            end
        end
    end
    crackConnections.NumObjects = size(crackConnections.PixelIdxList,1);
end
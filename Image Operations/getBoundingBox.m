function bbox = getBoundingBox(obj, imsize)
    ind_lin = obj(1);
    if rem(ind_lin,imsize) == 0
        ind = [imsize, floor(ind_lin/imsize)];
    else
        ind = [rem(ind_lin,imsize), floor(ind_lin/imsize)+1];
    end
    top_left = ind;
    bottom_right = ind;

    for i = 2:size(obj,1)
        ind_lin = obj(i);
        if rem(ind_lin,imsize) == 0
            ind = [imsize, floor(ind_lin/imsize)];
        else
            ind = [rem(ind_lin,imsize), floor(ind_lin/imsize)+1];
        end
        if ind(1) > bottom_right(1)
            bottom_right(1) = ind(1);
        end
        if ind(1) < top_left(1)
            top_left(1) = ind(1);
        end
        if ind(2) > bottom_right(2)
            bottom_right(2) = ind(2);
        end
        if ind(2) < top_left(2)
            top_left(2) = ind(2);
        end
    end
    bbox = [top_left bottom_right-top_left];
    bbox = [bbox(2) bbox(1) bbox(4) bbox(3)];
end
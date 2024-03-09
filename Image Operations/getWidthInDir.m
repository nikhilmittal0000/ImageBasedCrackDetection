function width = getWidthInDir(obj, coor, direction, imsize)
    width = 1;
    if direction == "E-W"
        i = 1;
        while true
            if any(obj == getIndex([coor(1),coor(2)+i], imsize))
                width = width + 1;
            else
                break;
            end
            i = i + 1;
        end
        i = 1;
        while true
            if any(obj == getIndex([coor(1),coor(2)-i], imsize))
                width = width + 1;
            else
                break;
            end
            i = i + 1;
        end
    end
    if direction == "N-S"
        i = 1;
        while true
            if any(obj == getIndex([coor(1)+i,coor(2)], imsize))
                width = width + 1;
            else
                break;
            end
            i = i + 1;
        end
        i = 1;
        while true
            if any(obj == getIndex([coor(1)-i,coor(2)], imsize))
                width = width + 1;
            else
                break;
            end
            i = i + 1;
        end
    end
end
function idx = getIndex(coor, imsize)
    idx = (coor(2)-1)*imsize(1)+ coor(1);
end
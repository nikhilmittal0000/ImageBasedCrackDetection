function coor = getCoordinates(idx, imsize)
    if rem(idx,imsize(1)) == 0
        coor = [imsize(1), floor(idx/imsize(1))];
    else
        coor = [rem(idx,imsize(1)), floor(idx/imsize(1))+1];
    end
end
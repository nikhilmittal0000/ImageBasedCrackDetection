function I_bottomHat = bottomHatTransform(I, len)
    % Crack detection at degrees
    deg = 0;
    S = strel("line",len,deg);
    I_0 = max(imclose(imopen(I,S),S),I)-I;
    %figure, imshow(I_0);
    deg = 45;
    S = strel("line",len,deg);
    I_45 = max(imclose(imopen(I,S),S),I)-I;
    %figure, imshow(I_45);
    deg = 90;
    S = strel("line",len,deg);
    I_90 = max(imclose(imopen(I,S),S),I)-I;
    %figure, imshow(I_90);
    deg = 135;
    S = strel("line",len,deg);
    I_135 = max(imclose(imopen(I,S),S),I)-I;
    %figure, imshow(I_135);
    I_bottomHat = I_0 + I_45 + I_90 + I_135;
end
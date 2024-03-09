clc;clear;close all;

% Image Reading
I_rgb = imread("Examples/example1.jpg");
I = rgb2gray(I_rgb);
imsize = size(I);

% Morphological technique for crack extraction
len = 10; % Size of structuring element
I_super = bottomHatTransform(I, len);

%Binarization
T = graythresh(I_super);
I_binarized = imbinarize(I_super,T);

% Cracks closing (eliminating false negatives)
I_binarized_cc = imclose(I_binarized,ones(5));

% Crack Detection and filtering (eliminating false positives)
pixel_threshold = 20;
bounding_box_threshold = 30;
[crack_connections, bounding_boxes] = detectCracks(I_binarized_cc, pixel_threshold, bounding_box_threshold);
I_binarized_filtered = insertShape(I, "rectangle", bounding_boxes, "LineWidth", 2);


%Crack Segmentation
I_segmented = zeros(size(I_rgb));
I_segmented(:,:,3) = 255;
for i = 1:crack_connections.NumObjects
    obj = crack_connections.PixelIdxList{i};
    for j = 1:size(obj,1)
        ind = getCoordinates(obj(j), imsize);
        I_segmented(ind(1),ind(2),:) = [255 0 0];
    end
end
%imwrite(I_segmented,"Segmented/"+ baseFileNameNoExt+ ".png");

% Calculating Crack width
averageWidth = calculateCrackWidth(crack_connections, imsize);

%Visualization
figure, imshow(I)
%figure, imshow(I_super);
%figure, imshow(I_binarized)
%figure, imshow(I_binarized_cc)
figure, imshow(I_binarized_filtered)
figure, imshow(I_segmented);
disp("Number of Cracks: " + crack_connections.NumObjects)
for i = 1:size(averageWidth,2)
    disp("Crack " + i + " width: " + averageWidth(i) + " px")
end
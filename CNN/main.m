clc; close all; clear;

% Load dataset
imds = imageDatastore("Dataset 1\Images");
pxds = pixelLabelDatastore("Segmented", ["crack", "concrete"],[255 0 0; 0 0 255]);
[imdsTrain,imdsTest,pxdsTrain,pxdsTest] = partitionData(imds,pxds, 0.8);
cds = combine(imdsTrain,pxdsTrain);

% Network Definition
imageSize = [256 256 3];
numClasses = 2;
network = 'resnet18';
lgraph = deeplabv3plusLayers(imageSize,numClasses,network, ...
             'DownsamplingFactor',16);

opts = trainingOptions('sgdm',...
    'MiniBatchSize',8,...
    'MaxEpochs',3, ...
    'Shuffle','every-epoch');

% Network Training
net = trainNetwork(cds,lgraph,opts);

% Network Evaluation
pxdsResults = semanticseg(imdsTest,net);
metrics = evaluateSemanticSegmentation(pxdsResults,pxdsTest);

% Visualization
I = imread("Dataset 1\Images\15.jpg");
C = semanticseg(I,net);
B = labeloverlay(I,C);
figure
imshow(B)
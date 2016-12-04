clear all 
fontSize = 20;
I = imread('test_8.jpg');
I = imresize(I, 0.5);
[L,N] = superpixels(I,500);
figure
BW = boundarymask(L);
imshow(imoverlay(I,BW,'cyan'),'InitialMagnification',67);

outputImage = zeros(size(I),'like',I);
idx = label2idx(L);
numRows = size(I,1);
numCols = size(I,2);
for labelVal = 1:N
    redIdx = idx{labelVal};
    greenIdx = idx{labelVal}+numRows*numCols;
    blueIdx = idx{labelVal}+2*numRows*numCols;
    outputImage(redIdx) = mean(I(redIdx));
    outputImage(greenIdx) = mean(I(greenIdx));
    outputImage(blueIdx) = mean(I(blueIdx));
end

figure
imshow(outputImage,'InitialMagnification',67)
imwrite(outputImage,'outputImage.png');
grayImage = rgb2gray(outputImage);

% Threshold the image to binarize it.
binaryImage = grayImage < 100;
binaryImage2 = grayImage > 100;
% Fill holes
binaryImage = imfill(binaryImage, 'holes');
binaryImage2 = imfill(binaryImage2, 'holes');
% Display the image.
figure;
imshow(binaryImage);
title('Binary Image', 'FontSize', fontSize);
figure;
imshow(binaryImage2);
% Get all the blob properties.  Can only pass in originalImage in version R2008a and later.
[labeledImage, numberOfBlobs] = bwlabel(binaryImage);
blobMeasurements = regionprops(labeledImage, 'area', 'Centroid');
% Get all the areas
allAreas = [blobMeasurements.Area]; % No semicolon so it will print to the command window.
menuOptions{1} = '0'; % Add option to extract no blobs.



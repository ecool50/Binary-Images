%% This is a demo showing how to use this toolbox

%   Copyright by Quan Wang, 2012/04/25
%   Please cite: Quan Wang. HMRF-EM-image: Implementation of the 
%   Hidden Markov Random Field Model and its Expectation-Maximization 
%   Algorithm. arXiv:1207.3510 [cs.CV], 2012.
function segment = preprocess(sample)
clear;clc;close all;

mex BoundMirrorExpand.cpp;
mex BoundMirrorShrink.cpp;
path = '/home/elijah/Desktop/CMPT-419-Project/HMRF-EM-image_v2.1/dataset_79/FW0001/B130628_01WHA_WILL_07592.JPG';
sample = 'B130628_01WHA_WILL_07592';
I=imread(path);
I = imresize(I, 0.1);
imshow(I)
Y=rgb2gray(I);
Z = edge(Y,'canny',0.75);

imwrite(uint8(Z*255),'edge.png');

Y=double(Y);
Y=gaussianBlur(Y,3);
imwrite(uint8(Y),'blurred image.png');

k=2;
EM_iter=10; % max num of iterations
MAP_iter=10; % max num of iterations

tic;
fprintf('Performing k-means segmentation\n');
[X, mu, sigma]=image_kmeans(Y,k);
imwrite(uint8(X*120),'initial labels.png');

[X, mu, sigma]=HMRF_EM(X,Y,Z,mu,sigma,k,EM_iter,MAP_iter);
imwrite(uint8(X*120),'final labels.png');
I = imread('initial labels.png');
bw = imbinarize(I);
ExtractNLargestBlobs(bw,2, sample);
toc;
end
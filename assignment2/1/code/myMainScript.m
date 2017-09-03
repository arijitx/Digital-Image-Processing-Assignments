%% MyMainScript


%% Q1. Image Sharping With Unsharp Mask 
% Suppose F is our original Image , 
% we take a Gaussian mask G with window size *win_size* and standard deviation *sigma* 
%
% Then We Convolve the Gaussian mask with the original image There we get
% our blured image .
%
% Then we negate that image from our original image to get our *unsharp mask*
%
% After that we multiply it with a scaling factor *scale* and add it to our
% original image to get the sharpen image 
%
% |F = F + scale*(F - G * F)|
%
tic;
im_mat=load('../data/lionCrop.mat');
im = im_mat.imageOrig;
res=myUnsharpMasking(im,21,15,.5);
imwrite(res,'../images/lionCrop.jpg');

im_mat=load('../data/superMoonCrop.mat');
im = im_mat.imageOrig;
res=myUnsharpMasking(im,30,15,.6);
imwrite(res,'../images/superMoonCrop.jpg');

toc;



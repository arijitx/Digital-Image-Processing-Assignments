%% Harris Corner Detection
%
% The Following Steps are performed 
% 
%  Initially the Image is blurred using a gaussian filter with sigma_1 std
%  The Blurring is done to introduce curve to step edges .
%  Now the Image Gradient is calculated in X and Y axis using imgradientxy()
%  function  
%
%%
% 
% <<f1.jpg>>
% 
%
%  Now we need to find Ix^2 ,Iy^2 and Ix.Iy to Construct Matrix A
%  We calculate Ix^2 , Iy^2 and Ix.Iy where Ix and Iy is our gradient
%  Now to Calculate <Ix^2> we need to average it over the window using
%  gaussain filter with sigma_2 std
%  Now After Finding A we calculate the eigen values of A namely E1 and E2
%  Now with E1 and E2 we calculate the Coreness Measure of that pixel 

%%
% 
% <<f2.jpg>>
% 
%% 
% *Parameters used:*
%%
% * Gaussian filter on image(sigma) = 2
% * Gaussian filter on gradient(sigma) = 2
% * k = 0.05

tic;

imat=load('../data/boat.mat');
im=imat.imageOrig;
im=mat2gray(im);
res=myHarrisCornerDetector(im,2,2,0.05);

toc;

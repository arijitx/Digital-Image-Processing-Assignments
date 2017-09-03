function res=myUnsharpMasking(im,wsize,sigma,scale)
%UNTITLED Summary of this function goes here
%   Function LiCS is defined to Linear Contrast Stretch a given Image
%   F = F + scale*(F - G * F)
    
    % create gaussian filter with wsize and sd sigma
    G=fspecial('gaussian',wsize,sigma);
    % do the conv with gaussian filter
    conv=imfilter(im,G,'replicate');
    % create the unsharp mask
    unsharp=im-conv;
    % add unsharp mask with originial image with scale s 
    res=im+scale*unsharp;
    
    figure('Name','Image Sharping with Unsharp Mask');
    colormap('gray');
    subplot(1,2,1)
    imagesc(LiCS(im));
    title('Original Image');
    axis image;
    
    subplot(1,2,2)
    imagesc(LiCS(res));
    title(strcat('Sharpened Image WinSize: ',int2str(wsize),' Sigma: ',num2str(sigma),' Scale: ',num2str(scale)));
    axis image;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    

end


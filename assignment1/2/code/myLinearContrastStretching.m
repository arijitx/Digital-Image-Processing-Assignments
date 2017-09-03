function myLinearContrastStretching(im,name)
    rgb_im_flag=0;
    if size(im,3)==3
        rgb_im_flag=1;
    end
    [r,c,ch]=size(im);
    res=zeros(r,c,class(im));
    max_i=zeros(ch);
    min_i=zeros(ch);
    for k=1:ch
        tempc=im(:,:,k);
        max_i(k)=max(tempc(:));
        min_i(k)=min(tempc(:));
    end
   
    for k=1:ch
        for i=1:r
            for j=1:c
                x=im(i,j,k);
                res(i,j,k)=(double(x-min_i(k))/double(max_i(k)-min_i(k)))*255;
            end
        end
    end
    
    
    figure('Name','Liniear Contrast Stretching');
    title('Liniear Contrast Stretching');
    colormap(gray(256));
    subplot(2,2,1),image(im)
    colorbar
    title('Original Image')
    axis image
    
    subplot(2,2,2),image(res)
    title('Contrast Stretched Image')
    colorbar
    axis image
    truesize
 
    %histogram of RGB image : https://stackoverflow.com/a/14682982/3832190
    if rgb_im_flag==1
        %if image is RGB
        subplot(2,2,3),hist(reshape(im,[],ch),0:255);
        colormap([1 0 0; 0 1 0; 0 0 1]);
        title('Original Histogram')
        
        subplot(2,2,4),hist(reshape(res,[],ch),0:255);
        colormap([1 0 0; 0 1 0; 0 0 1]);
        title('Contrast Stretched Histogram')
    else
        %if image is Grayscale
        subplot(2,2,3),imhist(im)
        title('Original Histogram')
        
        subplot(2,2,4),imhist(res)
        title('Contrast Stretched Histogram')
    end
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    imwrite(res,strcat('../images/A/',name));
        
end
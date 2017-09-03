function  res=myHE( im,show_figure )
%Histogram Equalization
%   Detailed explanation goes here
    % fetching image size
    [r,c,ch]=size(im);
    
    %initializing count and bin_locs array of shape [ch,256]
    count = zeros(ch,256);
    bin_locs=zeros(ch,256);
    
    %calculating histogram for each channel
    for k=1:ch
        [count(k,:),bin_locs(k,:)]=imhist(im(:,k));
    end
    
    %initializing result image
    res=zeros(r,c,class(im));
    
    %initializing pmf and cdf arrays of shape [ch,256]
    pmf=zeros(ch,256);
    cdf=zeros(ch,256);
    
    %for each channel calculating the pmf and cdf
    for k = 1:ch
        pmf(k,:)= count(k,:)/double(sum(count(k,:)));
        cdf(k,:)= cumsum(pmf(k,:));
    end
    
    %for each pixel transforming the pixel to new value using
    % the pre computed cdf 
    for k =1:ch
        for i=1:r
            for j=1:c
                res(i,j,k)=cdf(k,im(i,j,k)+1)*255;
            end
        end
    end
    
    %showing the results and original images with histogram 
    if show_figure ==1
        figure('Name','Histogram Equlization');
        title('Histogram Equalization');
        colormap(gray(256));
        subplot(2,2,1),image(im);
        title('Original Image');
        axis image
        subplot(2,2,2),image(res);
        title('Histogram Equalized');
        axis image
    
        if size(im,3)==3
            subplot(2,2,3),hist(reshape(im,[],ch),0:255);
            colormap([1 0 0; 0 1 0; 0 0 1]);
            title('Original Histogram')
            
            subplot(2,2,4),hist(reshape(res,[],ch),0:255);
            colormap([1 0 0; 0 1 0; 0 0 1]);
            title('Contrast Stretched Histogram')
        else
            subplot(2,2,3),imhist(im);
            subplot(2,2,4),imhist(res);
        end
    end
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);

end


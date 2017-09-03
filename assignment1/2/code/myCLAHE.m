


function  res=myCLAHE( im ,N,hist_thresh,show_figure)
%Contrast limited Adaptive Histogram Equalization
%   Detailed explanation goes here
    
    [r,c,ch]=size(im);
    
    %creating an image padded N rows and cols on the orginal so 
    % calculations of the image value can be done , those pixels are 
    % filled with mirror of the edge pixels
    new_im=zeros(r+N,c+N,class(im));
    new_im(N/2+1:r+(N/2),N/2+1:c+(N/2))=im;
    new_im(N/2+1:r+N/2,1:N/2) = flipdim(im(1:r,1:N/2),2);
    new_im(N/2+1:r+N/2,c+N/2+1:c+N) = flipdim(im(1:r,c-N/2+1:c),2);
    new_im(1:N/2,:)=flipdim(new_im(N/2+1:N,:),1);
    new_im(r+N/2+1:r+N,:)=flipdim(new_im(r+1:r+N/2,:),1);
    
    res=zeros(r,c,class(im));
    h = waitbar(0,'Computing CLAHE please wait . . . ');
    for i=1:r
        waitbar(i*100/r/100);
        for j=1:c
            roi=new_im(1+i:i+N,1+j:j+N);
            [counts,bin_locs]=imhist(roi);
            pmf=counts/double(sum(counts));
            mass=0;
            for k=1:256
                if pmf(k)>hist_thresh
                    mass=mass+(pmf(k)-hist_thresh);
                    pmf(k)=hist_thresh;
                end
            end
            mass=mass/255.0;
            for k=1:256
                pmf(k)=pmf(k)+mass;
            end
            cdf=cumsum(pmf);
            res(i,j)=cdf(im(i,j)+1)*255;
        end
    end
    close(h);
    if show_figure==1
        figure('Name',strcat('Histogram Equlized Image with CLAHE , Window size : ',int2str(N),' PMF Threshold',num2str(hist_thresh)));
        colormap(gray(256));
        subplot(2,2,1),image(im);
        title('Original Image');
        axis image
        subplot(2,2,2),image(res);
        title(strcat('CLAHE , Window size : ',int2str(N),' PMF Threshold',num2str(hist_thresh)));
        axis image
        subplot(2,2,3),imhist(im);
        subplot(2,2,4),imhist(res);

        set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    end
end
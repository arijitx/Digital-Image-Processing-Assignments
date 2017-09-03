function res = myPatchBasedFiltering( imr,win_size,patch_size,sigma,sigma_patch)

    %adding noise to image
    im=imr+5*randn(size(imr));
    [r,c]=size(im);
    
    %creating resulting image of size r,c
    res=zeros(r,c);
    
    %getting window size and patch size
    W=(win_size-1)/2;
    P=(patch_size-1)/2;
    
    %gaussian mask to make patches isotropic
    gaussian=fspecial('gaussian',patch_size,sigma_patch);
    
    %pad image on every size with size of window
    padded_im=padarray(im,[W+P,W+P],'symmetric');
    
    h=waitbar(0,'Patch Based Filtering');
    for i=1:r
        for j=1:c
            %getting original window
            window=padded_im(i+P:i+2*W+P,j+P:j+2*W+P);
            %getting window with padded p pixels on each side to handle
            %boundary patches
            padded_window=padded_im(i:i+2*W+2*P,j:j+2*W+2*P);
            
            [wr,wc]=size(window);
            %get the center patch
            center_patch=window(W-P:W+P,W-P:W+P);
            %declare inter patch distance matrix to store inter patch
            %distance
            inter_patch_dist=zeros(size(window));
            for k=1:wr
                for l=1:wc
                    %get patch region 
                    patch=padded_window(k:k+2*P,l:l+2*P);
                    %get difference of intensities with center patch 
                    diff=(center_patch-patch);
                    %add gaussian mask to difference to make patch
                    %isotropic
                    diff=diff.*gaussian;
                    %calculate interpatch euclidean distance
                    inter_patch_dist(k,l)=sum(sum(diff.^2))/(2*P+1)^2;

                end
            end
            %get weight for the whole window
            wt= exp(-inter_patch_dist/(sigma^2));
            %normalize weight
            wt=wt/(sum(sum(wt)));
            %get pixel intensity using normalized weight matrix
            res(i,j)=sum(sum(wt.*window));
        end
        waitbar(i/r);
    end
    close(h);
    
    subplot(2,2,1)
    colormap('gray');
    imagesc(imr);
    colorbar;
    title('Original Image');
    axis image;
    
    subplot(2,2,2)
    imagesc(im);
    colorbar;
    title('Noisy Image');
    axis image;
    
    subplot(2,2,3)
    imagesc(res);
    colorbar;
    title('Result Image');
    axis image;
    
    subplot(2,2,4)
    imagesc(gaussian);
    colorbar;
    title('Patch Mask Image');
    axis image;
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    disp('RMSD SCORE ');
    disp(RMSD(imr,res));

end


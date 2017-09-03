function res = myBilateralFiltering(im,sigma_d,sigma_r,win_size)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    corrupted=im+0.05*randn(size(im));
    
    res=zeros(size(im));
    [row,col]=size(im);
    
    N=(win_size-1)/2;
    
    
    
    h = waitbar(0,'Computing Smoothing');
    for i=1:row
        for j=1:col
            %get roi according to window size adjusting for boundary pixels
            i1=max(i-N,1);
            i2=min(i+N,row);
            j1=max(j-N,1);
            j2=min(j+N,col);
            roi=corrupted(i1:i2,j1:j2);
            
            %I(i,j)-center
            %-[I(i,j)-center_p]^2/(2sigma_r^2)
            I_diff=roi(:,:)-corrupted(i,j);
            I=-(I_diff.^2)/(2*(sigma_r)^2);
            
            %compute distance from center pixels to all other pixels in
            %window 
            [X,Y]=meshgrid((j1:j2)-j+N+1,(i1:i2)-i+N+1);
            G=-(X.^2+Y.^2)/(2*sigma_d^2);
            
            
            %w(i,j,k,l)=exp(I+G)
            W=exp(I+G);
            
            %calculate neum and denominator of Id(i,j)
            nf=sum(sum(roi(:,:).*W));
            df=sum(sum(W));
            res(i,j)=nf/df;
            
        end
        waitbar(i/row); 
    end
    close(h)
    
    disp('RMSD VALUE : ');
    disp(RMSD(im,res));
    
    figure('Name','BilateralFiltering');
    colormap('gray');
    
    subplot(1,3,1)
    imagesc(im);
    colorbar;
    title('Original Image');
    axis image;
    
    subplot(1,3,2)
    imagesc(corrupted);
    colorbar;
    title('Corrupted Image');
    axis image;
    
    subplot(1,3,3)
    imagesc(res);
    colorbar;
    title('Smoothed Image');
    axis image;
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    figure('Name','Gaussian Mask');
    colormap('gray');
    gaussiand=fspecial('gaussian',win_size,sigma_d);
    gaussianr=fspecial('gaussian',win_size,sigma_r);
    
    subplot(1,2,1)
    imagesc(gaussiand);
    title('Gaussian Mask on Spatial');
    axis image;
    
    subplot(1,2,2)
    imagesc(gaussianr);
    title('Gaussian Mask on Intensity');
    axis image;
    
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
end


function res = myHarrisCornerDetector (im,sigma_1,sigma_2,k)
    
    %creating the 2 gaussain filters
    g1=fspecial('gaussian',[3,3],sigma_1);
    g2=fspecial('gaussian',[3,3],sigma_2);
    
    %initial blurring the image
    im=imfilter(im,g1,'same');
    [r,c]=size(im);
    
    
    %Calculate image gradients
    [Ix,Iy]=imgradientxy(im);
    
    %Find elements of A (Ix2, Iy2,IxIy)
    Ix2=Ix.^2;
    Iy2=Iy.^2;
    IxIy=Ix.*Iy;
    
    
    %initalize cornerness and eignevalues for all pixels
    Mc=zeros(size(im));
    e1=zeros(size(im));
    e2=zeros(size(im));
    
    w=waitbar(0,'Calculating Corners');
    % leave 2 pixels from each side
    for i=2:r-1
        for j=2:c-1
            %calculate elements of A over the 3x3 window size
            Ix2_=sum(sum(g2.*Ix2(i-1:i+1,j-1:j+1)));
            Iy2_=sum(sum(g2.*Iy2(i-1:i+1,j-1:j+1)));
            IxIy_=sum(sum(g2.*IxIy(i-1:i+1,j-1:j+1)));
            
            %structure tensor
            A=[Ix2_ IxIy_ ; IxIy_ Iy2_ ];

            %get eign value
            E=eig(A);
            e1(i,j)=E(1);
            e2(i,j)=E(2);
            
            %calculate cornerness measure
            Mc(i,j)=E(1)*E(2)-k*(E(1)+E(2))^2;          
        end
        waitbar(i/r);
    end
    close(w)
    w=waitbar(0,'Drawing Markers');
    
    %Draw Corners in Image
    im_with_corners=im;
    for i=1:r
        for j=1:c
            if(Mc(i,j)>0.05)
                im_with_corners=insertMarker(im_with_corners,[j,i]);
            end
        end
        waitbar(i/r);
    end
    
    close(w);
    
    
    %original Image and Cornerness
    figure
    colormap(gray);
    subplot(1,2,1),imagesc(im);axis image;title('Original Image');colorbar;
    subplot(1,2,2),imagesc(Mc);axis image;title('Corner Ness');colorbar;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    %eigen values of structure tensor
    figure
    colormap(gray);
    subplot(1,2,1),imagesc(e1);axis image;title('Eigen 1');colorbar;
    subplot(1,2,2),imagesc(e2);axis image;title('Eigen 2');colorbar;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    %eigen values of structure tensor
    figure
    colormap(gray);
    subplot(1,2,1),imagesc(Ix);axis image;title('Gradient Along X');colorbar;
    subplot(1,2,2),imagesc(Iy);axis image;title('Gradient Along Y');colorbar;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    %image with corners
    figure
    colormap(gray);
    imagesc(im_with_corners);
    title('Image with Corners');
    axis image;
    set(gcf, 'Units', 'Normalized', 'OuterPosition', [0 0 1 1]);
    
    res=Mc;
    
end
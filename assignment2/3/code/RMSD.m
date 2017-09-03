function rmsd = RMSD( im1,im2 )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here
    [r,c]=size(im1);
    n=r*c;
    rmsd=(sum(sum((im1-im2).^2))/n).^0.5;
    

end


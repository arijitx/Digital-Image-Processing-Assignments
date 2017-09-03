function shrinked_image=myShrrinkImageByFactorD(im,factor)
[row,col]=size(im);
shrinked_row=int64(row/factor);
shrinked_col=int64(col/factor);
shrinked_image=zeros(shrinked_row,shrinked_col,class(im));

for i=1:shrinked_row
  for j=1:shrinked_col
    x=factor*i-1;
    y=factor*j-1;
    shrinked_image(i,j)=im(x,y);
  end
end
end




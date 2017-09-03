function enlarged = myBilinearInterpolation(im)
%Bilinear Interploation to Enlarge M x N Image to (3M - 2) x (2N - 1) Image
%   Detailed explanation goes here
[r,c]=size(im);
new_r=3*r-2;
new_c=2*c-1;
enlarged=zeros(new_r,new_c,class(im));
for i=1:r
    for j=1:c
        enlarged(3*i-2,2*j-1)=im(i,j);
    end
end

%// first fill rows 
% | A | x | B |
% | o | o | o |
% | o | o | o |
% | C | x | D |
% fill the x rowise in the first go 

for i=1:3:new_r
    for j=1:new_c
        if(mod(j,2)==0)
            enlarged(i,j)=enlarged(i,j-1)/2+enlarged(i,j+1)/2;
        end
    end
end

% now fill the columns
% | A | X | B |
% | o | o | o |
% | o | o | o |
% | C | X | D |
% now fill column wise the o as ABCD is known and Xs are calculated 
% in last step

for j=1:new_c
    i=2;
    while(i<=new_r)
        enlarged(i,j)=enlarged(i-1,j)*(2/3)+enlarged(i+2,j)*(1/3);
        i=i+1;
        enlarged(i,j)=enlarged(i-2,j)*(1/3)+enlarged(i+1,j)*(2/3);
        i=i+2;
    end
end
        
            
end


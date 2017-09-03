function enlarged =myNearestNeighborInterpolation( im )
%Nearest Neighbor Interploation to Enlarge M x N Image to (3M - 2) x (2N - 1) Image
[r,c]=size(im);
new_r=3*r-2;
new_c=2*c-1;
enlarged=zeros(new_r,new_c,class(im));

for i=1:r
    for j=1:c
        enlarged(3*i-2,2*j-1)=im(i,j);
    end
end

for i=1:3:new_r
    for j=1:new_c
        if(mod(j,2)==0)
            enlarged(i,j)=enlarged(i,j-1);
        end
    end
end

for j=1:new_c
    i=2;
    while(i<=new_r)
        enlarged(i,j)=enlarged(i-1,j);
        i=i+1;
        enlarged(i,j)=enlarged(i+1,j);
        i=i+2;
    end
end

    
end


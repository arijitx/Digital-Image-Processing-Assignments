function segment_image = myMeanShiftSegmentation (image,sigma_pos,sigma_col,max_iterations)
imageSize = size(image);
row = imageSize(1);
columns = imageSize(2);

%%%%%%%%%%%%%%%%%%%%%% create 5-D feature space %%%%%%%%%%%%%%%%%%%%
opImage = zeros(row*columns,5);
for i = 1:row
    for j = 1:columns
        opImage(i*columns-columns+j,:) = [i;j;image(i,j,1);image(i,j,2);image(i,j,3);];
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for gaussian kernel 
opImage(:,1:2)=opImage(:,1:2)/(1.414*sigma_pos);      % spatial
opImage(:,3:5)=opImage(:,3:5)/(1.414*sigma_col);      % color intensity

h = waitbar(0,'Computing Segmentation using Mean-Shift');
for iteration = 1:max_iterations
    
    [IDX, D] = knnsearch(opImage, opImage, 'K', 75);  % no Of Neighbours = 75
    %%% IDX contains index and D contains distance of neighbours
    kernel = exp(-(D.^2));           % gaussian kernel
    
    for i = 1:row*columns            %  for every pixel
         sum_distance = sum(kernel(i,:));
         distance = kernel(i,:)';
         kernel_matrix = [distance, distance, distance];  
         
         %%%%%%%%%%% finding mean and assign it to pixel %%%%%%%%%%%%%%%
         opImage(i, 3:5) = sum(kernel_matrix.*(opImage(IDX(i,:),3:5)))/sum_distance;      
    end
    waitbar(iteration/max_iterations);
end
close(h);

%%%%%%%%%%%%%%%%%%%%%% produce final output image  %%%%%%%%%%%%%%%%%%%%%%%
segment_image = zeros(row,columns,3);
for i = 1:row
    for j = 1:columns
        segment_image(i,j,:) = opImage(i*columns-columns+j,3:5);
    end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

end
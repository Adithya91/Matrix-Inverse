function theMatrixProduct = mat_parfor(mat1, mat2)
if(size(mat1)==size(mat2))
theMatrixProduct = zeros(size(mat1));
parfor i = 1:size(mat1,1)
    theMatrixProduct(i,:) = mat2(i,:) * mat1;
end
else
    [x1, x2] = size(mat1);
    [y1, y2] = size(mat2);
    theMatrixProduct = zeros(x1, y2);
    for row = 1 : x1
        for col = 1 : y2
            mat_sum = 0;
            parfor k = 1 : x2
                mat_sum = mat_sum + mat1(row, k) * mat2(k, col);
            end
            theMatrixProduct(row, col) = mat_sum;
        end
    end
    
end
end
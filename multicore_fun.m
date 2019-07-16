function matrixProduct = multicore_fun(mat1,mat2,settings)
cores = 4;
s = size(mat1);
row = s(1);
div = row/cores;
parameterCell = cell(1, cores);
for k = 1:cores
  tempcell = cell(2,1);
  tempcell{1,1} = mat2(floor(div*(k-1))+1:floor(div*k),:);
  tempcell{2,1} = mat1;
  parameterCell{1,k} = tempcell;
end


result = startmulticoremaster(@multiply_fun, parameterCell, settings);
for k = 1:cores
    matrixProduct = [result{1,1};result{1,2};result{1,3};result{1,4}];
end 
end


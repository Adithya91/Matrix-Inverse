%%Loading Matrix
load bcsstk08.mat;
%%Sparse Matrix
G = Problem.A;
%%Converting to dense form
G = full(G);
G_T = transpose(G);
G_Inv = inv(G);
%%Constructing vector b

for i=1:length(G)
    if(mod(i,2)==1)
        vec(i)=1;
    else
        vec(i)=2;
    end
end

b= vec';

B = cell(1,size(G,1));
R_B = cell(1,size(G,1));
Error = cell(1,size(G,1));
I = eye(size(G));

fprintf('1.Task1\n2.Task2\n3.Task3\n4.Task4\n')
n = input('Enter a number: ');

switch n
    %%%Task 1
    case 1
        fprintf('Executing task 1..\n');
        tic;
        %Part a
        B{1,1} = G_T/trace(G_T*G);
        i = 1;
        while (1)
            R_B{1,i} = I - B{1,i}*G;
            B{1,i+1} = (I+R_B{1,i})*B{1,i};
            Error{1,i}  = norm(R_B{1,i});
            if (Error{1,i} < 0.9)
                break
            end
            i = i+1;
        end
        %Part b
        x = B{1,i}*b;
        toc;
        check = round(G * x); %% Check b = G * x
    case 2
        %%%Using For Loop
        fprintf('Executing task 2..\n');
        %Part a
        tic;
        B{1,1} = G_T/trace(mat_multiply(G_T,G));
        for i=1:size(G,1)
            R_B{1,i} = I - mat_multiply(B{1,i},G);
            B{1,i+1} = mat_multiply((I+R_B{1,i}),B{1,i});
            Error{1,i}  = norm(R_B{1,i});
            if (Error{1,i} <  0.9)
                break
            end
        end
        %Part b
        x = mat_multiply(B{1,i},b);
        toc;
        check = round(G * x); %% Check b = G * x
    case 3
        %%%Using ParFor Loop
        fprintf('Executing task 3..\n');
        %Part a
        tic;
        B{1,1} = G_T/trace(mat_parfor(G_T,G));
        for i=1:size(G,1)
            R_B{1,i} = I - mat_parfor(B{1,i},G);
            B{1,i+1} = mat_parfor((I+R_B{1,i}),B{1,i});
            Error{1,i}  = norm(R_B{1,i});
            if (Error{1,i} <  0.9)
                break
            end
        end
        %Part b
        x = mat_parfor(B{1,i},b);
        toc;
        check = round(G * x); %% Check b = G * x
    case 4  
        tic;        
        _multicore('E:\Multicore', G,G_T,I,B,R_B,Error,b);
        toc;
end
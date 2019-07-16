function lab3multicore(multicoreDir,G,G_T,I,B,R_B,Error,b)

% If debug_full mode is activated, more info will be displayed.
debug_fullMode = 0;

% Check if directory is given, otherwise use standard directory
if exist('multicoreDir', 'var')
    settings.multicoreDir = multicoreDir;
else
    settings.multicoreDir = '';
end
%settings.nrOfEvalsAtOnce = 1; % default: 4
settings.masterIsWorker = false; % default: true
settings.useWaitbar = true;

if debug_fullMode
    fprintf('********** Parameters set in multicoredemo.m:\n');
    fprintf('masterIsWorker    = %d\n',   settings.masterIsWorker);
    fprintf('nrOfEvalsAtOnce   = %d\n',   settings.nrOfEvalsAtOnce);
    fprintf('nrOfEvals         = %d\n',   nrOfEvals);
end

% Call function STARTMULTICOREMASTER.
%Part a
B{1,1} = G_T/trace(G_T*G);
i=1;
while(1)
    R_B{1,i} = I - multicore_fun(B{1,i},G,settings);
    B{1,i+1} = multicore_fun((I+R_B{1,i}),B{1,i},settings);
    Error{1,i}  = norm(R_B{1,i});
    if (Error{1,i} <  0.9)
        break
    end
    i = i+1;
end
%Part b
x = B{1,i}*b;
disp(size(x));


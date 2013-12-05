%**************************************************************************
%
%**************************************************************************
function output=som(input)
    
    %% Initializations  
    munits = prod(input.mapdim);
    
    % Initialize codebook/weights
    codebook = initCodeBookVectors(input.data,input.mapdim,input.weightsInitFun);
    coords = nodeCoords(input.mapdim);
    nodeDist = getCoordDist(munits,coords);
    qe = zeros(1,input.maxIter);
    te = qe;
    cost = qe;
    
    %% Iterate
    for iter=1:input.maxIter      
        [codebook u bmu hu h m Dx cost(iter)] = somStep(input, codebook, iter, nodeDist);
        fprintf('Iteration %d, obj fun = %f\n',iter, cost(iter));    
    end

    D = nodePairwiseDist(input.datatype,codebook,input.data);
    [umatrix uheight] = somUmatrix(input.mapdim,D);
    
    %% Generate output structure
    output = struct('config',input,...
                    'codebook',codebook,...
                    'codebookDist',D,...
                    'vis',struct('umatrix',umatrix,'uheight',uheight),...
                    'u',u,...
                    'bmu',bmu,...
                    'hu',hu,...
                    'h',h,...
                    'Dx',Dx,...
                    'fuzzifier',m,...
                    'cost',cost,...
                    'date',datestr(now, 'mmmm dd, yyyy HH:MM AM'));
end

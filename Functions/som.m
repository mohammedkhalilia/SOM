%**************************************************************************
%
%**************************************************************************
function output=som(input)
    
    %% Initializations  
    munits = prod(input.mapdim);
    
    % Initialize codebook/weights
    codebook = init_codebooks(input.data,input.mapdim,input.weightsInitFun);
    coords = node_coords(input.mapdim);
    nodeDist = coord_dist(munits,coords);
    qe = zeros(1,input.maxIter);
    te = qe;
    cost = qe;
    
    %% Iterate
    for iter=1:input.maxIter      
        [codebook u bmu hu h m Dx cost(iter)] = som_step(input, codebook, iter, nodeDist);
        fprintf('Iteration %d, obj fun = %f\n',iter, cost(iter));    
    end

    D = node_pairwise_dist(input.datatype,codebook,input.data);
    [umatrix uheight] = som_umatrix(input.mapdim,D);
    
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

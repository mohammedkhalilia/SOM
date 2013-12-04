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
    
    %% open video writer handle
    if isfield(input,'umatmovie')
        umat_frames(trainLen) = struct('cdata',[],'colormap',[]);
        vw = VideoWriter(input.umatmovie);
        open(vw);
    end

    %% Iterate
    for iter=1:input.maxIter      
        [codebook u bmu hu h m Dx cost(iter)] = somStep(input, codebook, iter, nodeDist);
        fprintf('Iteration %d, obj fun = %f\n',iter, cost(iter));    
        
        %write frame to video file if video filename is given
        if isfield(input,'umatmovie')
            umatrix = somUmatrix(codebook,input.mapdim,input.datatype, input.data);
            umat_frames(iter) = umatrixFrame(umatrix);
            writeVideo(vw,umat_frames(iter));
        end
        
        [qe(iter) te(iter)] = quality(u, Dx, input.mapdim, m);
        
        %[~,map] = fuzzyTopographicError(input.mapdim, u(:,100));
        %figure;
        %imagesc(1-map);
        %colormap(gray(256))
        %set(gca,'YDir','normal');
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
                    'fuzzifier',m,...
                    'eval',struct('qe',qe,'te',te,'cost',cost),...
                    'date',datestr(now, 'mmmm dd, yyyy HH:MM AM'));
                
    %% close the video writer handle
    if isfield(input,'umatmovie')
        output.umatframes = umat_frames;
        close(vw);
    end
end

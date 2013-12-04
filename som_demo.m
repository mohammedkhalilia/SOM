function output = som_demo(varargin)
% test = som_demo('alg','frbsom','dataset',dataset(6),'iterNum',1,'m',[1.01 2],'maxIter',10,'radius',[2 0.5]);
    % alg: bsom, fbsom, rbsom, frbsom

    tic;
    
    %evaluate the paramters
    for i=1:2:length(varargin)
        eval([genvarname(varargin{i}) ' = varargin{i+1};']);
        if strcmp(varargin{i},'dataset')
            dataset = varargin{i+1};
        end
    end
    
    if strcmp(alg,'bsom') || strcmp(alg,'fbsom'), DID = 1;
    elseif strcmp(alg,'frbsom') || strcmp(alg,'rbsom'); DID = 2;end
    
    results = zeros(4,iterNum);
   
    for i=1:iterNum
        fprintf('Iteration #%d\n',i);

        input.name              = dataset.name;
        input.datatype          = dataset.data(DID).type;
        input.data              = dataset.data(DID).x;
        input.mode              = alg;
        input.maxIter           = maxIter;
        input.mapdim            = dataset.mapsize;
        input.radius            = radius;
        if exist('m','var'),    input.fuzzifier = m;end
        if exist('lrate','var'),input.lrate = lrate;end
        input.weightsInitFun    = 'random';
        %input.umatmovie         = sprintf('output/Maps/%s.avi',alg);

        smap = som(input);
        %figure;
        %surf(smap.vis.uheight);
        %colormap(gray);
        
        output.config = smap.config;
        output.smap(i) = rmfield(smap,'config');
        
        if isfield(dataset,'u') && ~isempty(dataset.u)
            [results(1,i),~,~] = randIndex(smap.u,dataset.u,1);
        end
        
        [tef ~] = fuzzyTopographicError(input.mapdim, smap.u);
        
        results(2,i) = smap.eval.qe(end);
        results(3,i) = smap.eval.te(end);
        results(4,i) = tef;
        results(5,i) = smap.eval.cost(end);
        
        figure;
        summarization(output.smap(i), output.config, dataset);
        
    end

    fprintf('\n\n---------------------------------------------\nResults:\n\n');
    fprintf('%s\t%20s\t%21s\t%21s\t%21s\t%21s\n','Alg.','Avg RI (Std Dev)','Quan. Err. (Std Dev)','Top. Err. (Std Dev)','Fuzzy Top. Err. (Std Dev)','Obj. Fun. (Std Dev)');
    fprintf('%s\t%10f (%f)\t%10f (%f)\t%10f (%f)\t%10f (%f)\t%20f (%f)\n',...
            char(alg),...
            mean(results(1,:)),std(results(1,:)),...
            mean(results(2,:)),std(results(2,:)),...
            mean(results(3,:)),std(results(3,:)),...
            mean(results(4,:)),std(results(4,:)),...
            mean(results(5,:)),std(results(5,:)));    
        
    toc;
    
end

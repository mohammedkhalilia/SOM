function somCompare(varargin)
    lineStyle = {'-k' '--k' '-.k' '--k'};
    
    % evaluate the paramters
    for i=1:length(varargin)
        som(i) = varargin{i};
        
        cost = zeros(1,length(som(i).smap));
        for m=1:length(som(i).smap)
            cost(m) = som(i).smap(m).eval.cost(end);
        end
        
        [~, idx] = min(cost);
    
        soms(i).smap = som(i).smap(idx);
        soms(i).config = som(i).config;
    end

    % plot the quantization error
    figure;plot(soms(1).smap.eval.qe,lineStyle{1},'LineWidth',2); 
    legendInfo{1} = upper(soms(1).config.mode);
    hold on;
    for i=2:length(soms)
       plot(soms(i).smap.eval.qe,lineStyle{i},'LineWidth',2);
       legendInfo{i} = upper(soms(i).config.mode);
    end
    
    xlabel('Iteration')
    ylabel('Quantization Error')
    legend(legendInfo);
    %title('Quantization Error');
    hold off;
    
    % plot the topographic error
    figure;plot(soms(1).smap.eval.te,lineStyle{1},'LineWidth',2); 
    hold on;
    for i=2:length(soms)
       plot(soms(i).smap.eval.te,lineStyle{i},'LineWidth',2);
    end
    
    xlabel('Iteration')
    ylabel('Topographic Error')
    legend(legendInfo);
    %title('Topographic Error');
    hold off;
    
    % plot the objective function value
    figure;plot(soms(1).smap.eval.cost,lineStyle{1},'LineWidth',2); 
    hold on;
    for i=2:length(soms)
       plot(soms(i).smap.eval.cost,lineStyle{i},'LineWidth',2);
    end
    
    xlabel('Iteration')
    ylabel('Objective Function')
    legend(legendInfo);
    %title('Objective Function Value');
    hold off;
    
    n = size(som(1).config.data,1);
    c = prod(som(1).config.mapdim);
    ari = zeros(1,length(som(1).smap));
    
    for i=1:length(som(1).smap)
        [~, u1] = max(som(1).smap(i).u);
        [~, u2] = max(som(2).smap(i).u);
        
        u1 = sparse(u1,1:n,1,c,n);
        u2 = sparse(u2,1:n,1,c,n);
        
        %[ari(i),~,~] = randIndex(u1,u2,2);
        ind = ComparingPartitions( u1 , u2 );
        ari(i) = ind(8);
    end
    
    mean(ari)
    std(ari)
end
function codebook = update_codebooks(varargin)
    
    %evaluate the paramters
    for i=1:2:length(varargin)
        eval([genvarname(varargin{i}) ' = varargin{i+1};']);
    end
 
    %udate the new codebooks
    switch(mtype)
        case 'VORONOI'
            %% Generate Voronoi Set
            % Source: Fast Evolutionary Learning with Batch-Type Self-Organizing Maps
            % Note: this will display the neurons in 2D, thus this will not
            % work for to visiualize the relational data
            
            codebook = zeros(size(h,1),size(x,2));   
            
            if exist('m','var')
                S = (u.^m)*x;
                A = sum(u.^m,2) * ones(1,size(x,2));
            else
                S = u*x;
                A = sum(u,2) * ones(1,size(x,2));
            end
            
            nonzero = find(A > 0);
            codebook(nonzero) = S(nonzero)./A(nonzero);
            
        case 'ONLINE' 
            %% Online SOM update
            codebook = codebook - (h*ones(1,size(Dx,2))).*Dx;
            
        case 'BATCH'
            %% Batch SOM update
            codebook = zeros(size(h,1),size(x,2));   
            S = h*(u*x);
            A = h*(u*~isnan(x));
            nonzero = find(A > 0);
            codebook(nonzero) = S(nonzero)./A(nonzero);
           
        case 'FUZZYBATCH'
            %% Fuzzy batch SOM update
            codebook = zeros(size(h,1),size(x,2));
            S = (h.^m)*(u.^m*x);
            A = (h.^m)*(u.^m*~isnan(x));
            nonzero = find(A > 0);
            codebook(nonzero) = S(nonzero)./A(nonzero);      
            
        case 'RELATIONAL'
            %% Relational batch SOM update
            codebook = h(:,bmu)./(sum(h(:,bmu),2)*ones(1,length(bmu)));

        case 'RELATIONALFUZZY'
            %% Fuzzy relational batch SOM update   
            codebook = (h.^m) * (u.^m);
            S = sum(codebook,2)*ones(1,size(u,2));
            nonzero = find(S > 0);
            codebook(nonzero) = codebook(nonzero)./S(nonzero);
    end
end

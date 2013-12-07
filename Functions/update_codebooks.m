function V = update_codebooks(varargin)
    
    %evaluate the paramters
    for i=1:2:length(varargin)
        eval([genvarname(varargin{i}) ' = varargin{i+1};']);
    end
 
    %udate the new codebooks
    switch(alg)
        case 'VORONOI'
            %% Generate Voronoi Set
            % Source: Fast Evolutionary Learning with Batch-Type Self-Organizing Maps
            % Note: this will display the neurons in 2D, thus this will not
            % work for to visiualize the relational data
            
            V = zeros(size(h,1),size(x,2));   
            
            if exist('m','var')
                S = (u.^m)*x;
                A = sum(u.^m,2) * ones(1,size(x,2));
            else
                S = U*x;
                A = sum(U,2) * ones(1,size(x,2));
            end
            
            nonzero = find(A > 0);
            V(nonzero) = S(nonzero)./A(nonzero);
            
        case 'ONLINE' 
            %% Online SOM update
            V = V - (h*ones(1,size(Dcn,2))).*Dcn;
            
        case 'BATCH'
            %% Batch SOM update
            V = zeros(size(h,1),size(x,2));   
            S = h*(U*x);
            A = h*(U*~isnan(x));
            nonzero = find(A > 0);
            V(nonzero) = S(nonzero)./A(nonzero);
           
        case 'FUZZYBATCH'
            %% Fuzzy batch SOM update
            V = zeros(size(h,1),size(x,2));
            S = (h.^m)*(U.^m*x);
            A = (h.^m)*(U.^m*~isnan(x));
            nonzero = find(A > 0);
            V(nonzero) = S(nonzero)./A(nonzero);      
            
        case 'RELATIONAL'
            %% Relational batch SOM update
            V = h(:,bmu)./(sum(h(:,bmu),2)*ones(1,length(bmu)));

        case 'RELATIONALFUZZY'
            %% Fuzzy relational batch SOM update   
            V = (h.^m) * (U.^m);
            S = sum(V,2)*ones(1,size(U,2));
            nonzero = find(S > 0);
            V(nonzero) = V(nonzero)./S(nonzero);
    end
end

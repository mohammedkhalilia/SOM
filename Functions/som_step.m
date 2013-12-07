function [V U bmu Dcn cost] = som_step(input, V, iter, nodeDist)
%%
% Perform one step for the iterative SOM algorithm. Here we will compute
% and update the following:

%   1. update distance between the codebook vector and the patterns
%   2. codebook vectors or relational codebooks, 
%   3. the best matching units (BMU) for the crisp algorithms 
%   4. update the fuzzy partitions if a fuzzy algorithm is used.
%   5. update the neighborhood function 
%   6. update the radius
%   7. update the learning rate for the ONLINE algorithm
%

    x = input.data;
    [n ~] = size(x);
    trainLen = input.maxIter;
    munits = prod(input.dim);
    bmu = zeros(1,n);
    Dcn = zeros(munits,n);
    r = input.radius(1) * (input.radius(2)/input.radius(1))^(iter/trainLen);
    
    if isfield(input,'fuzzifier')
        m = input.fuzzifier(1) * (input.fuzzifier(2)/input.fuzzifier(1))^((iter-1)/trainLen);
    end
    
    switch(input.alg)
        case 'ONLINE'
            %% Online SOM case
            ri = ceil(n*rand);
            xi = x(ri,:);                     % pick one sample vector
            Dcn = V - (xi'*ones(1,munits))';      % each map unit minus the vector
            
            [~, bmu] = min(sqrt(sum(Dx.^2,2)));       % minimum distance and the BMU
            U = sparse(bmu,1:n,1,prod(input.mapdim),n);
            l = input.learningRate(1) * (input.learningRate(2)/input.learningRate(1))^(iter/trainLen);
            h = l * exp(-nodeDist/(2*r^2)); 
            V = update_codebooks('alg',input.alg,'h',h,'Dcn',Dcn,'codebook',V);
                    
        case 'BATCH'
            %% Batch SOM case
            for i=1:n
                tmp = V - (x(i,:)'*ones(1,munits))';      
                Dcn(:,i) = sqrt(sum(tmp.^2,2));
            end
        
            [~, bmu] = min(Dcn,[],1);        
            U = full(sparse(bmu,1:n,1,prod(input.dim),n));
            h = exp(-nodeDist/(2*r^2)); 
            V = update_codebooks('alg',input.alg,'h',h,'U',U,'x',x);
         
            % update the value of the objective function
            UD = U .* (h * Dcn);
            cost = sum(UD(:));
            
        case 'FUZZYBATCH'
            %% Fuzzy batch SOM case            
            for i=1:n
                d = V - (x(i,:)'*ones(1,munits))';  
                Dcn(:,i) = sqrt(sum(d.^2,2));       
            end
            
            % update the neighbhorhood function
            h = exp(-nodeDist/(2*r^2));
            
            %hd is more like the topographic distance, it is the distance
            %weighted by the neighborhood function
            hd = (h.^m)*Dcn;
            
            tmp = zeros(size(hd));
            
            %ignore zero elements, they will cause problems
            nonzero = find(hd > 0);
            tmp(nonzero) = hd(nonzero).^(-1/(m-1));
            
            %again, we might run into zero elements here. those elements
            %gets propgrated from hd. So we need to handle those as well.
            stmp = sum(tmp);
            S = ones(munits, 1)*stmp;
            nonzero = find(S > 0);
            
            %update the membership values
            U = zeros(munits,n);
            
            %find where the sum of distance columns is zero, that means a
            %point equal distant from every neuron, then just assign an
            %equal membership of 1/c
            zero = stmp == 0;
            U(:,zero) = 1/munits; 
            U(nonzero) = tmp(nonzero) ./ S(nonzero);
            
            V = update_codebooks('alg',input.alg,'U',U,'h',h,'bmu',bmu,'m',m,'x',x);

            % update the value of the objective function  
            hu = (h.^m); 
            UD = (U.^m) .* (hu * Dcn);
            cost = sum(UD(:));
            
            %best matching unit, if you do not want memberships
            [~,bmu] = max(U);
            
        case 'RELATIONAL'
            %% Relational batch case
            
            for a=1:munits
                Dcn(a,:) = x * V(a,:)' - V(a,:) * x * V(a,:)'/2;
            end
            
            [~, bmu] = min(Dcn,[],1);
            U = full(sparse(bmu,1:n,1,prod(input.dim),n));
            h = exp(-nodeDist/(2*r^2)); 
            V = update_codebooks('alg',input.alg,'h',h,'bmu',bmu);
            
            % update the value of the objective function
            hu = h * U;
            UD = hu .* (hu * x);
            UD = sum(UD,2)./sum(hu,2);
            cost = sum(UD(:))/2;
            
        case 'RELATIONALFUZZY'
            %% Fuzzy relational batch case
            % update the dictance between all objects and the codebooks
            for a=1:munits
                Dcn(a,:) = x * V(a,:)' - V(a,:) * x * V(a,:)'/2;
            end
            
            % update the neighbhorhood function
            h = exp(-nodeDist/(2*r^2));
            
            %hd is more like the topographic distance, it is the distance
            %weighted by the neighborhood function
            hd = (h.^m)*Dcn;
            
            tmp = zeros(size(hd));
            
            %ignore zero elements, they will cause problems
            nonzero = find(hd > 0);
            tmp(nonzero) = hd(nonzero).^(-1/(m-1));
            
            %again, we might run into zero elements here. those elements
            %gets propgrated from hd. So we need to handle those as well.
            stmp = sum(tmp);
            S = ones(munits, 1)*stmp;
            nonzero = find(S > 0);
            
            %update the membership values
            U = zeros(munits,n);
            
            %find where the sum of distance columns is zero, that means a
            %point equal distant from every neuron, then just assign an
            %equal membership of 1/c
            zero = stmp == 0;
            U(:,zero) = 1/munits; 
            U(nonzero) = tmp(nonzero) ./ S(nonzero);
            
            % updatde the coefficient
            V = update_codebooks('alg',input.alg,'U',U,'h',h,'m',m,'D',x);
            
            % update the value of the objective function
            hu = (h.^m) * (U.^m);      
            UD = hu .* (hu * x);
            UD = sum(UD,2)./(2*sum(hu,2));
            cost = sum(UD(:));
            
            %best matching unit, if you do not want memberships
            [~,bmu] = max(U);
    end

end

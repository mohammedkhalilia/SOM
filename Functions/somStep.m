function [codebook u bmu hu h m Dx cost] = somStep(input, codebook, iter, nodeDist)
    x = input.data;
    [n ~] = size(x);
    trainLen = input.maxIter;
    munits = prod(input.mapdim);
    bmu = zeros(1,n);
    Dx = zeros(munits,n);
    r = input.radius(1) * (input.radius(2)/input.radius(1))^(iter/trainLen);
    
    if isfield(input,'fuzzifier')
        m = input.fuzzifier(1) * (input.fuzzifier(2)/input.fuzzifier(1))^((iter-1)/trainLen);
    else
        m=1;
    end
    
    switch(input.mode)
        case 'online'
            %% Online SOM case
            ri = ceil(n*rand);
            xi = x(ri,:);                     % pick one sample vector
            Dx = codebook - (xi'*ones(1,munits))';      % each map unit minus the vector
            
            [~, bmu] = min(sqrt(sum(Dx.^2,2)));       % minimum distance and the BMU
            u = sparse(bmu,1:n,1,prod(input.mapdim),n);
            l = input.lrate(1) * (input.lrate(2)/input.lrate(1))^(iter/trainLen);
            h = l * exp(-nodeDist/(2*r^2)); 
            codebook = updateCodeBookVectors('mtype','online','h',h,'Dx',Dx,'codebook',codebook);
                    
        case 'bsom'
            %% Batch SOM case
            for i=1:n
                tmp = codebook - (x(i,:)'*ones(1,munits))';      
                Dx(:,i) = sqrt(sum(tmp.^2,2));
            end
        
            [~, bmu] = min(Dx,[],1);        
            u = full(sparse(bmu,1:n,1,prod(input.mapdim),n));
            h = exp(-nodeDist/(2*r^2)); 
            codebook = updateCodeBookVectors('mtype','bsom','h',h,'u',u,'x',x);
         
            % update the value of the objective function
            UD = u .* (h * Dx);
            cost = sum(UD(:));
            hu=0;
            
        case 'fbsom'
            %% Fuzzy batch SOM case            
            for i=1:n
                d = codebook - (x(i,:)'*ones(1,munits))';  
                Dx(:,i) = sqrt(sum(d.^2,2));       
            end
            
            % update the neighbhorhood function
            h = exp(-nodeDist/(2*r^2));
            
            %hd is more like the topographic distance, it is the distance
            %weighted by the neighborhood function
            hd = (h.^m)*Dx;
            
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
            u = zeros(munits,n);
            
            %find where the sum of distance columns is zero, that means a
            %point equal distant from every neuron, then just assign an
            %equal membership of 1/c
            zero = stmp == 0;
            u(:,zero) = 1/munits; 
            u(nonzero) = tmp(nonzero) ./ S(nonzero);
            
            codebook = updateCodeBookVectors('mtype','fbsom','u',u,'h',h,'bmu',bmu,'m',m,'x',x);

            % update the value of the objective function  
            hu = (h.^m);% * (u.^m);     
            UD = (u.^m) .* (hu * Dx);
            cost = sum(UD(:));
            
        case 'rbsom'
            %% Relational batch case
            
            for a=1:munits
                Dx(a,:) = x * codebook(a,:)' - codebook(a,:) * x * codebook(a,:)'/2;
            end
            
            Dx(Dx < 0) = 0;
            [~, bmu] = min(Dx,[],1);
            u = full(sparse(bmu,1:n,1,prod(input.mapdim),n));
            h = exp(-nodeDist/(2*r^2)); 
            codebook = updateCodeBookVectors('mtype','rbsom','h',h,'bmu',bmu);
            
            % update the value of the objective function
            hu = h * u;
            UD = hu .* (hu * x);
            UD = sum(UD,2)./sum(hu,2);
            cost = sum(UD(:))/2;
            
        case 'frbsom'
            %% Fuzzy relational batch case
            % update the dictance between all objects and the codebooks
            for a=1:munits
                Dx(a,:) = x * codebook(a,:)' - codebook(a,:) * x * codebook(a,:)'/2;
            end
            
            Dx(Dx < 0) = 0;
            
            % update the neighbhorhood function
            h = exp(-nodeDist/(2*r^2));
            
            %hd is more like the topographic distance, it is the distance
            %weighted by the neighborhood function
            hd = (h.^m)*Dx;
            
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
            u = zeros(munits,n);
            
            %find where the sum of distance columns is zero, that means a
            %point equal distant from every neuron, then just assign an
            %equal membership of 1/c
            zero = stmp == 0;
            u(:,zero) = 1/munits; 
            u(nonzero) = tmp(nonzero) ./ S(nonzero);
            
            % updatde the coefficient
            codebook = updateCodeBookVectors('mtype','frbsom','u',u,'h',h,'m',m,'D',x);
            
            % update the value of the objective function
            hu = (h.^m) * (u.^m);      
            UD = hu .* (hu * x);
            UD = sum(UD,2)./(2*sum(hu,2));
            cost = sum(UD(:));
    end

end

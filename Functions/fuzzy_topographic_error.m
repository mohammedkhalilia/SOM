function varargout = fuzzy_topographic_error(map, type)
%% 
% Measure the quality of the fuzzy SOM
%
% 
% Khalilia, M. and Popescu, M. "Topology Preservation in Fuzzy Self-Organizing Maps". 
% Adv. Trends Soft Comput. (2014).

    U = map.U;
    [c, n] = size(U);
    
    switch type
        case 1
            %compute the ratio between different in membership between two
            %neurons and the distance between them and sum overall neuron
            %and input patterns.
            %Closer neurons with small different in membership to a given
            %pattern contribute less to the error than close neurons with
            %larger difference in membership to the input pattern.
            
            coords = node_coords(map.config.dim);
            nodeDist = squareform(pdist(coords,'euclidean'));
            err = zeros(1,n);

            for k=1:n
                tmp = [];

                for i=1:c
                    d = abs(U(i,k)-U(i+1:end,k)') ./ nodeDist(i,i+1:end);
                    tmp = [tmp d];
                end
                
                err(k) = mean(tmp);
            end
            
            varargout{1} = mean(err);
        
        case 2 %image sgementation based technique
    
            y = map.config.dim(1);
            x = map.config.dim(2);
            mapTmp = zeros(y,x,n);
    
            %% Build individual maps for every object
            % If we loop through every object this process will take a very long
            % time, instead we loop through every neuron.

            for j=1:y     
                for i=1:x
                    S1 = sub2ind(map.config.dim, j, i);
                    neighbors = node_neighbors(map.config.dim, j,i);
                    temp = abs(U(neighbors,:) - (ones(length(neighbors),1) * U(S1,:)));
                    mapTmp(j,i,:) = sum(temp);
                end  
            end

            %% Topographic Error
            % Calculate the TE error for every object. 
            % 1) Due to variations in the error for every neuron across different
            % paramaters (radius, fuzzifier, etc), we have to normalize the map by
            % dividing by the sum of its elements.
            % 
            % 2) Using a threshold (mean + standard deviation) we divide the map to
            % separate the neurons with high and low errors.
            %
            % 3) Apply watershed to segment those neurons with high and low values
            %
            % 4) Look for the neurons that are enclosed within a wall (watershed 
            % marks them greater them with values greater then 1)
            %
            % 5) What if there are no enclosed neurons? Use the neuron with high
            % values (marked with values 1)
            %
            % 6) Return the average error across all neurons
            for i=1:n
                temp = mapTmp(:,:,i);
                temp = temp./sum(temp(:));
                m = im2bw(temp,graythresh(temp));%temp > mean(temp(:));% + std(temp(:));
                w = watershed(m);
                regions = unique(w);

                if length(regions) > 2
                    %if there are neurons enclosed, sum their values
                    regionSize = [];
                    for r=1:length(regions)
                        regionSize(regions(r)+1) = length(find(w == regions(r)));
                    end
                    [~, maxRegion] = max(regionSize);
                    idx = w ~=0 & w~=maxRegion-1;
                    te = te + sum(temp(idx));
                else
                    %if not then it means the neurons are not enclosed and the
                    %watershed could not find a single valley where that object is
                    %located. This can also means the object is assigned to
                    %multiple neurons that are not in one geographical location
                    %
                    %then pretty much sum all high points in the map. and sometimes
                    %due to the low threshold all pixel values are sumed
                    idx = w == 1;
                    te = te + sum(temp(idx));
                end
            end

            varargout{1} = te/n;
            varargout{2} = mapTmp;
            
    end
end
function [qe te] = quality(map)
%% Measure the quality of the map
%   Quantization Error (qe): measures the average distance between each 
%       data vector and its best matching unit (BMU). The smaller the 
%       quantization error, the smaller the average of the distance from 
%       the vector data to the prototypes, and that means, that the data 
%       vectors are closer to its prototypes.
%
%   Topographic Error (te): r measures the proportion of all 
%       data vectors for which first and second best-matching units 
%       (BMU) are not adjacent vectors. So the lower the topographic 
%       error is, the better the Self-Organizing Map preserves the topology. 
%
%   Source: "Topology preservation in self-organizing maps", K. Kiviluoto
%           Proceedings of International Conference on Neural Networks (ICNN'96) 1 p. 294-299
%
%           "Topology preservation in SOM", E Arsuaga Uriarte, F Díaz Martín, (2005)
%           International Journal of Mathematical and Computer Sciences

    coords = node_coords(map.config.dim);
    nodeDist = squareform(pdist(coords,'euclidean'));
    U = map.U;
    Dcn = map.Dcn;
    
    % Quantization error (QE)
    if isfield(map.config,'fuzzifier')
        m = map.config.fuzzifier(2);
        UD = (U.^m) .* Dcn; 
    else
        UD = U.*Dcn; 
    end
            
    qe = sum(UD(:))/size(U,2);
            
    %Topographic Error (Same for Fuzzy and Crisp cases)
    if isfield(map.config,'fuzzifier')
        [~, idx] = sort(U,1);
        idx = sub2ind(size(nodeDist), idx(1,:),idx(2,:));
        te = 1-nodeDist(idx);
        te(te ~= 0) = 1;
        te = sum(te)/size(Dcn,2);
    else
        [~, idx] = sort(Dcn,1);
        idx = sub2ind(size(nodeDist), idx(1,:),idx(2,:));
        te = 1-nodeDist(idx);
        te(te ~= 0) = 1;
        te = sum(te)/size(Dcn,2);
    end
end
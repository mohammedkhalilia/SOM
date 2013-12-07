function idx = node_neighbors(mapdim,j,i)
%%
% Given a neuron with coordinates (i,j) and a map with dimensions mapdim,
% return the indices of the 4 immediate neighbors to that neuron.

    y = mapdim(1);
    x = mapdim(2);    
    idx = [];
    count = 1;
    
    if i>1 
        idx(count) = sub2ind(mapdim, j, i-1);
        count = count + 1;
    end

    if j>1
        idx(count) = sub2ind(mapdim, j-1, i);
        count = count + 1;
    end

    if i<x % horizontal
        idx(count) = sub2ind(mapdim, j, i+1); 
        count = count + 1;
    end 

    if j<y % vertical
        idx(count) = sub2ind(mapdim, j+1, i);
    end
end
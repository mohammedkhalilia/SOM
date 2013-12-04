function idx = neuronImmediateNeighbors(mapdim,j,i)
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
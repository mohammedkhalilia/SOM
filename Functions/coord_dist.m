%**************************************************************************
%
%**************************************************************************
function nodeDist = coord_dist(munits,coords)
    nodeDist = zeros(munits);
    for i=1:munits-1
        inds = i+1:munits;
        coordi = repmat(coords(i,:),length(inds),1);
        nodeDist(i,inds) = sqrt(sum((coordi-coords(inds,:)).^2,2));
    end
    
    nodeDist = nodeDist + nodeDist';
end
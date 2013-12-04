function D = nodePairwiseDist(type,w,R)
    switch(type)
        case 'relational'
            c = size(w,1);
            D = zeros(c);
            t2 = diag(0.5*w*R*w');
            
            for i=1:c
                D(i,:) = w*R*w(i,:)' - t2 - 0.5*w(i,:)*R*w(i,:)';
            end
            
            D(D < 0) = 0;
            
        case 'relationalpdist'
            D = pdist(w,@relationalDist, R);
            
        otherwise
            D = squareform(pdist(w,'euclidean'));
    end 
end

function D = relationalDist(wi, w, R)
    n = size(w,1);
    D = zeros(n,1);
    
    for j=1:n
        D(j) = w(j,:)*R*wi' - 0.5*w(j,:)*R*w(j,:)'- 0.5*wi*R*wi';
    end
end
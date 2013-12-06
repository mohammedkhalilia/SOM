function D = node_pairwise_dist(alg,w,R)
    switch(alg)
        case 'RELATIONAL'
        case 'RELATIONALFUZZY'
            c = size(w,1);
            D = zeros(c);
            t2 = diag(0.5*w*R*w');
            
            for i=1:c
                D(i,:) = w*R*w(i,:)' - t2 - 0.5*w(i,:)*R*w(i,:)';
            end
            
            D(D < 0) = 0;
            
        case 'relationalpdist'
            D = pdist(w,@relational_dist, R);
            
        case 'ONLINE'
        case 'BATCH'
        case 'FUZZYBATCH'
            D = squareform(pdist(w,'euclidean'));
    end 
end

function D = relational_dist(wi, w, R)
    n = size(w,1);
    D = zeros(n,1);
    
    for j=1:n
        D(j) = w(j,:)*R*wi' - 0.5*w(j,:)*R*w(j,:)'- 0.5*wi*R*wi';
    end
end
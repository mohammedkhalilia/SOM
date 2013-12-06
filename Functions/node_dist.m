function D = node_dist(alg,w,R)
    switch(alg)
        case {'RELATIONAL','RELATIONALFUZZY'}
            c = size(w,1);
            D = zeros(c);
            t2 = diag(0.5*w*R*w');
            
            for i=1:c
                D(i,:) = w*R*w(i,:)' - t2 - 0.5*w(i,:)*R*w(i,:)';
            end
            
        case {'ONLINE','BATCH','FUZZYBATCH'}
            D = squareform(pdist(w,'euclidean'));
    end 
end
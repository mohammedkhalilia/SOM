function D = node_dist(alg,w,R)
%%
% Compute the pairwise distances among neurons. If we are using object SOM
% then we will use Euclidean distance in d space. If we are using
% relational SOM then we will use the relational distance in n space.
%
% n = #patterns, d = #dimensions

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
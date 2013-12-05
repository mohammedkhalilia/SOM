%**************************************************************************
%
%**************************************************************************
function [codebook map] = init_codebooks(x, mapdim, initfun)
    K = mapdim(1);
    J = mapdim(2);
    [n d] = size(x);
    map = repmat(struct('x',0,'y',0),K,J);
    
    switch(initfun)
        case 'random'
            codebook = rand(K*J,d);
        case 'randompatterns'
            randIdx = randperm(n)' * ones(1,ceil((K*J)/n));
            codebook = x(randIdx(1:K*J),:);
    end
    
    codebook = codebook./(sum(codebook,2)*ones(1,size(x,2)));
end
dataset = som_dataset({'ws3g'});

input.data              = dataset.relationalData;
input.alg               = 'RELATIONALFUZZY';
input.maxIter           = 10;
input.dim               = dataset.mapsize;
input.radius            = [2 0.5];
input.fuzzifier         = [1.01 2];
input.weightsInitFun    = 1;
        
map = som(input);

[qe te] = quality(map);
[tef ~] = fuzzy_topographic_error(map);
        
figure;summarization(map, dataset);
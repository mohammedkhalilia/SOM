dataset = som_dataset({'ws3g'});

input.data              = dataset.relationalData;
input.alg               = 'RELATIONALFUZZY';
input.maxIter           = 10;
input.mapdim            = dataset.mapsize;
input.radius            = [2 0.5];
input.fuzzifier         = [1.01 2];
input.weightsInitFun    = 1;
        
map = som(input);

[qe te] = quality(map.u, map.Dx, map.config.mapdim, 2);
[tef ~] = fuzzy_topographic_error(map.config.mapdim, map.u);
        
figure;summarization(map, dataset);
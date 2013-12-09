clear;

%load the dataset, see som_dataset.m for details
dataset = som_dataset({'cvr'});

input.data              = dataset.relationalData;
input.alg               = 'RELATIONALFUZZY';
input.maxIter           = 10;
input.dim               = dataset.mapsize;
input.radius            = [2 0.5];
input.fuzzifier         = [1.1 1.5];
input.weightsInitFun    = 1;
        
map = som(input);

%compute the topographic and quantization errors
[qe te] = quality(map);

%compute the fuzzy topographic error (only for the fuzzy versions of SOM)
[tef ~] = fuzzy_topographic_error(map);
        
%summarize the map
figure;summarization(map, dataset);
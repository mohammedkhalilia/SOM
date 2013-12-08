%load the dataset, see som_dataset.m for details
dataset = som_dataset({'ws3g'});

input.data              = dataset.objectData;
input.alg               = 'BATCH';
input.maxIter           = 10;
input.dim               = dataset.mapsize;
input.radius            = [2 0.5];
%input.fuzzifier         = [1.01 2];
input.weightsInitFun    = 1;
        
map = som(input);

%compute the topographic and quantization errors
%[qe te] = quality(map);

%compute the fuzzy topographic error (only for the fuzzy versions of SOM)
%[tef ~] = fuzzy_topographic_error(map);
        
%summarize the map
figure;summarization(map, dataset);
Self-Organizing Map (SOM)
==================================

Overview
----------------------------------
This Self-Organizing Maps (SOM) toolbox is a collection of 5 different
algorithms all derived from the original Kohonen network. The 5
 algorithms are:

   `ONLINE`      - the online SOM (see ref. [1])
   
   `BATCH`       - the batch version of SOM
   
   `FUZZYBATCH`  - this is the fuzzy batch SOM, where there is no Best
                 Matching Unit (BMU) instead every neuron is a winner with 
                 some degree. This degree is a fuzzy value where 1 indicates 
                 winner take-all and 0 is not a winner.
                 
   `RELATIONAL`  - use relational SOM with relational data. When you do not
                 have the feature vectors instead you have the dissimilatities 
                 among objects in a relational data matrix D (see ref. [2])
                 
   `RELATIONALFUZZY` - a combination of the RELATIONAL SOM and FUZZY BATCH SOM (see ref. [3])

NOTE: this toolbox includes a function named summarization() that attempts to summarize the results of SOM by adding a layer of labels on the map. This function is a work in progress and it still needs tweaking. Feel free to use it and modify it as you wish. Also, this function a built-in MATLAB function watershed() to segment the U-matrix and to identify the regions/clusters. watershed() is part of the image processing toolbox. Additionlly, summarizing SOM is problem specific. The function included in this toolbox is just an example on how to do it. 

SOM Configurations
----------------------------------

### Input
Input to SOM is a structure with the following fields:

 `data`           - either the feature vector data organized in a _n_ x _d_ matrix or a dissimilarity data in matrix _n_ x _n_
                  
 `alg`            - which algorithm to use, which of course depends on the type of data you provided. The alg can take any of the 5 different algorithms mentioned above
                  
 `maxIter`        - maximum number of iterations SOM will run before it terminates
 
 `radius`         - array of two elements indicating the start and end of the SOM neighborhood radius

 `learningRate`   - array of two elements indicating the start and end learning rate used by the ONLINE algorithm

 `fuzzifier`      - array of two elements indicating the start and end values of the fuzzifier
                  
 `weightInitType` - indicates the type of weight/codebook _V_ initialization

> 1 = random initialization

> 2 = randomly select _c_ rows from the data to initialize the codebooks, where _c_ is the number of neurons</p>

### Output
The output is also a structure with the following fields:

 `config`    - this field contains the input structure to SOM described above

 `V`         - _c_ x _d_ matrix containing codebook vectors/centers _V_ for objects SOM or _c_ x _n_ relational codebooks for relational SOM

 `U`         - _c_ x _n_ fuzzy/crisp partition matrix. For crisp SOM _U_ contains elements with 0 and 1 and elements indicates the best matching unit or winning neuron for the object

 `Dcc`       - _c_ x _c_ matrix containing pairsewise dissimilarities among neurons (Euclidean distance or relational distance in _d_ or _n_ space)

 `Dcn`       - _c_ x _n_ matrix of the distances between neurons and patterns

 `umatrix`   - visual map that can be displayed in 2D or 3D to visualize the cluster boundaries

 `bmu`       - the list of best matching units of patterns. For fuzzy SOM algorithms this corresponds to the hardened partition of _U_. 


The datasets are prepared and configured in the script som_dataset.m for convenience, but it is not required that you use that script. Instead you can directly supply the data to the SOM input struct field data. However, storing the dataset information in a structure as it is in som_dataset.m is better specially when using summarization.m. This way you can define additional fields in the dataset structure that you can use in summarization.m.

Examples SOM with Object Data
----------------------------------

### Example. 1 SOM with Object Data
The following example demonstrates how to use this toolbox with the BATCH version of SOM.

	%load the dataset, see som_dataset.m for details
	dataset = som_dataset({'ws3g'});

	input.data              = dataset.objectData;
	input.alg               = 'BATCH'; %can be replaced with ONLINE, 
	input.maxIter           = 10;
	input.dim               = dataset.mapsize;
	input.radius            = [2 0.5];
	input.weightsInitFun    = 1;
        
	map = som(input);

	%compute the topographic and quantization errors
	[qe te] = quality(map);
        
	%summarize the map
	%dataset must have a field labels that is an array of labels for every pattern
	figure;summarization(map, dataset);

### Example. 2 SOM with Relational Data
The following example demonstrates how to use this toolbox with the BATCH version of SOM.

	%load the dataset, see som_dataset.m for details
	dataset = som_dataset({'ws3g'});

	input.data              = dataset.relationalData;
	input.alg               = 'RELATIONAL'; %can be replaced with ONLINE, 
	input.maxIter           = 10;
	input.dim               = dataset.mapsize;
	input.radius            = [2 0.5];
	input.weightsInitFun    = 1;
        
	map = som(input);

	%compute the topographic and quantization errors
	[qe te] = quality(map);

	%summarize the map
	%dataset must have a field labels that is an array of labels for every pattern
	figure;summarization(map, dataset);

### Example. 3 Fuzzy SOM with Relational Data
The following example demonstrates how to use this toolbox with the BATCH version of SOM.

	%load the dataset, see som_dataset.m for details
	dataset = som_dataset({'ws3g'});

	input.data              = dataset.relationalData;
	input.alg               = 'RELATIONALFUZZY';
	input.maxIter           = 10;
	input.dim               = dataset.mapsize;
	input.radius            = [2 0.5];
	input.fuzzifier 		= [1.1 2];  %% NOTE: for fuzzy algorithms we have to add the fuzzifier 
	input.weightsInitFun    = 1;
        
	map = som(input);

	%compute the topographic and quantization errors
	[qe te] = quality(map);


	%compute the fuzzy topographic error (only for the fuzzy versions of SOM)
	tef = fuzzy_topographic_error(map);

	%summarize the map
	%dataset must have a field labels that is an array of labels for every pattern
	figure;summarization(map, dataset);

To run Fuzzy SOM for object just replace the first two SOM inputs to reflect that as follows

	input.data              = dataset.objectData;
	input.alg               = 'FUZZYBATCH';

References
----------------------------------
1. T. Kohonen, “The self-organizing map,” Neurocomputing, 1998.
2. Hasenfuss, A. & Hammer, B. Relational topographic maps. Advances in Intelligent Data Analysis VII (2007). at <http://www.springerlink.com/index/D0664R20V2L83MX5.pdf>
3. Khalilia, M. & Popescu, M. Fuzzy relational self-organizing maps. in 2012 IEEE International Conference on Fuzzy Systems 1–6 (IEEE, 2012). doi:10.1109/FUZZ-IEEE.2012.6250833
4. Khalilia, M. and Popescu, M. "Topology Preservation in Fuzzy Self-Organizing Maps". Adv. Trends Soft Comput. (2014).

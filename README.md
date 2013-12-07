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
 `data`           - either the feature vector data organized in a n x d matrix or a
                  dissimilarity data in matrix n x n
                  
 `alg`            - which algorithm to use, which of course depends on the type of
                  data you provided. The alg can take any of the 5 different algorithms
                  mentioned above
                  
 `maxIter`        - maximum number of iterations SOM will run before it terminates
 
 `radius`         - array of two elements indicating the start and end of the SOM
                  neighborhood radius

 `learningRate`   - array of two elements indicating the start and end learning rate used by the ONLINE algorithm

 `fuzzifier`      - array of two elements indicating the start and end values of
                  the fuzzifier
                  
 `weightInitType` - indicates the type of weight/codebook initialization
                   1 = random initialization
                   2 = randomly select c rows from the data to initialize the
                  codebooks, where c is the number of neurons

References
----------------------------------
1. T. Kohonen, “The self-organizing map,” Neurocomputing, 1998.
2. Hasenfuss, A. & Hammer, B. Relational topographic maps. Advances in Intelligent Data Analysis VII (2007). at <http://www.springerlink.com/index/D0664R20V2L83MX5.pdf>
3. Khalilia, M. & Popescu, M. Fuzzy relational self-organizing maps. in 2012 IEEE International Conference on Fuzzy Systems 1–6 (IEEE, 2012). doi:10.1109/FUZZ-IEEE.2012.6250833
4. Khalilia, M. and Popescu, M. "Topology Preservation in Fuzzy Self-Organizing Maps". Adv. Trends Soft Comput. (2014).

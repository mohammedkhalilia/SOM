function umatrix = som_umatrix(mapdim,Dcc)
%%
% Compute the U-matrix and U-height for visualizing the results of SOM.
% U-matrix is displayed in 2D and U-height is displayed in 3D.
%
% Usage: [umatrix uheight] = som_umatrix(mapdim,Dcc)
% 
% mapdim    - dimensions of the map
% Dcc       - c x c matrix contaning pairwise distances among neurons
% umatrix   - matrix having same dimenions as the SOM map where the value
%             at every neuron coordinate is the sum of the distances between that
%             neuron and its four immediate neighbors. For more details on
%             the umatrix see ref. below.
%
% Clustering with SOM: U* C. A Ultsch (2005) Proc. Workshop on Self- Organizing Maps p. 75–82
% Or this link
% http://www.informatik.uni-marburg.de/~databionics/papers/Ultsch09U-Matrix.pdf

    y = mapdim(1);
    x = mapdim(2);
    umatrix = zeros(y,x,4);
    
    for j=1:y
        for i=1:x
            S1 = sub2ind(mapdim, j, i);
                    
            if(i > 1)
                S2 = sub2ind(mapdim, j, i-1);
                umatrix(j,i,1) = Dcc(S1,S2); 
            end

            if(j > 1)
                S2 = sub2ind(mapdim, j-1, i);
                umatrix(j,i,2) = Dcc(S1,S2);
            end

            if i<x % horizontal
                S2 = sub2ind(mapdim, j, i+1);
                umatrix(j,i,3) = Dcc(S1,S2);
            end 

            if j<y % vertical
                S2 = sub2ind(mapdim, j+1, i);
                umatrix(j,i,3) = Dcc(S1,S2);
            end
        end
    end   
           
    umatrix = sum(umatrix,3);
end
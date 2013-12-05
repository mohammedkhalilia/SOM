%**************************************************************************
% Usage: umatrix(codebook,[10 10],'sum','',data)
%       codebook: #nodes x #features
%
% Source: 
%    http://www.uni-marburg.de/fb12/datenbionik/pdf/pubs/1990/UltschSiemon90
%**************************************************************************

function [umatrix uheight] = som_umatrix(mapdim,D)
    y = mapdim(1);
    x = mapdim(2);
    umatrix = zeros(2*y - 1,2*x - 1);
    uheight = zeros(y,x,4);
    
    for j=1:y
        for i=1:x
            S1 = sub2ind(mapdim, j, i);
                    
            if(i > 1)
                S2 = sub2ind(mapdim, j, i-1);
                uheight(j,i,1) = D(S1,S2); 
            end

            if(j > 1)
                S2 = sub2ind(mapdim, j-1, i);
                uheight(j,i,2) = D(S1,S2);
            end

            if i<x % horizontal
                S2 = sub2ind(mapdim, j, i+1);
                umatrix(2*j-1,2*i) = D(S1,S2);
                uheight(j,i,3) = D(S1,S2);
            end 

            if j<y % vertical
                S2 = sub2ind(mapdim, j+1, i);
                umatrix(2*j,2*i-1) = D(S1,S2);
                uheight(j,i,3) = D(S1,S2);
            end
                    
            if j<y & i<x % diagonals
                S2 = sub2ind(mapdim, j+1, i+1);
                dz1 = D(S1,S2);
                        
                S1 = sub2ind(mapdim, j, i+1);
                S2 = sub2ind(mapdim, j+1, i);
                dz2 = D(S1,S2);
                        
                umatrix(2*j,2*i) = (dz1 + dz2)/2;
            end
                    
            umatrix(2*j - 1,2*i - 1) = sum(uheight(j,i,:));
        end
    end   
           
    uheight = sum(uheight,3);
end
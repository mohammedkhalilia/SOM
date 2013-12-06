function [te mapTmp] = fuzzy_topographic_error(map)
    u = map.u;
    y = map.config.dim(1);
    x = map.config.dim(2);
    [~, n] = size(u);
    mapTmp = zeros(y,x,n);
    te = 0;
    
    %% Build individual maps for every object
    % If we loop through every object this process will take a very long
    % time, instead we loop through every neuron.
    
    for j=1:y     
        for i=1:x
            S1 = sub2ind(map.config.dim, j, i);
            neighbors = neuron_neighbors(map.config.dim, j,i);
            temp = abs(u(neighbors,:) - (ones(length(neighbors),1) * u(S1,:)));
            mapTmp(j,i,:) = sum(temp);
        end  
    end
    
    %% Topographic Error
    % Calculate the TE error for every object. 
    % 1) Due to variations in the error for every neuron across different
    % paramaters (radius, fuzzifier, etc), we have to normalize the map by
    % dividing by the sum of its elements.
    % 
    % 2) Using a threshold (mean + standard deviation) we divide the map to
    % separate the neurons with high and low errors.
    %
    % 3) Apply watershed to segment those neurons with high and low values
    %
    % 4) Look for the neurons that are enclosed within a wall (watershed 
    % marks them greater them with values greater then 1)
    %
    % 5) What if there are no enclosed neurons? Use the neuron with high
    % values (marked with values 1)
    %
    % 6) Return the average error across all neurons
    for i=1:n
        temp = mapTmp(:,:,i);
        temp = temp./sum(temp(:));
        m = im2bw(temp,graythresh(temp));%temp > mean(temp(:));% + std(temp(:));
        w = watershed(m);
        regions = unique(w);
        
        if length(regions) > 2
            %if there are neurons enclosed, sum their values
            regionSize = [];
            for r=1:length(regions)
                regionSize(regions(r)+1) = length(find(w == regions(r)));
            end
            [~, maxRegion] = max(regionSize);
            idx = w ~=0 & w~=maxRegion-1;
            te = te + sum(temp(idx));
        else
            %if not then it means the neurons are not enclosed and the
            %watershed could not find a single valley where that object is
            %located. This can also means the object is assigned to
            %multiple neurons that are not in one geographical location
            %
            %then pretty much sum all high points in the map. and sometimes
            %due to the low threshold all pixel values are sumed
            idx = w == 1;
            te = te + sum(temp(idx));
        end
    end
    
    if n == 1
        figure;imagesc(w);set(gca,'YDir','normal');
        figure;imagesc(1-mapTmp);
        colormap(gray(256)); %gray(256) or Jet
        set(gca,'YDir','normal');
    end
    
    te = te/n;
end
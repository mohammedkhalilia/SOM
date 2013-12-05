function [region fig] = summarization(map, config, dataset)
    coords = node_coords(config.mapdim);
    
    %this hardens the memberships and assigned a single neuron to every
    %object
    [~,object2neuron] = max(map.u);
    
    %for every neuron find the objects with the highest membership.
    %Basically, we are finding the representive object for the neuron which
    %is the object with the highest membership or coefficient
    [~,neuron2object] = max(map.u,[],2);
    
    %track which neuron belongs to which region
    neuron2region = zeros(prod(config.mapdim),1);
    
    WS = watershed(map.vis.uheight);
    regionInd = unique(WS);
    regionInd = regionInd(2:end);
    region = regionprops(WS);
    
    %imagesc makes the y-axis run from top to bottom, which will cause a
    %problem once we annotate the map with labels. We fix this issue using
    %flipud function
    %imagesc(flipud(1-map.vis.uheight));
    fig = imagesc(1-map.vis.uheight);
    colormap(gray(256)); %gray(256) or Jet
    set(gca,'YDir','normal');
    
    parentImgPos = get(gca,'Position');
    parentImgAxis = axis;
    
    %keep track of which objects are used so far
    objectsFound = [];
           
    switch(dataset.name)
       case 'ADL'
           %dimensions of the trajectory dim = [width height]
           dim = [0.1 0.1];
           
           %add label for every region
           for r=1:length(regionInd)
               rid = regionInd(r);
               regionTitle = sprintf('R%d',rid);
               text(region(rid).Centroid(1),region(rid).Centroid(2),regionTitle,'FontWeight','bold');
           end     
           
           %add ADL trajectory for every region
           for r=1:length(regionInd)
                rid = regionInd(r);
               
                %get the indicies for the neurons representing this region 
                neuronInds = find(WS == rid);
                region(rid).NeuronIndex = neuronInds;
                
                %assign the region ID to that neuron
                neuron2region(neuronInds) = rid;
                
                %save the coordinates of the neurons belonging to that
                %region
                region(rid).Neurons = coords(neuronInds,:);
                
                %find the data points belongning to that region, we use the
                %maximum value in the membership matrix to determine which
                %point belongs to which neurons in that region
                region(rid).Objects = find(ismember(object2neuron, neuronInds)==1);
                objectsFound = [objectsFound region(rid).Objects];
                
                %for every neuron get the representive object
                %it is the object with the highest cooefficient
                %
                %for crisp SOM we do not have representives for every
                %neurons since the u{ik} = {0,1} so all objects with
                %membership 1 are representitive of that neuron
                if strcmp(config.mode,'frbsom')
                    reps = neuron2object(neuronInds);
                else
                    reps = region(rid).Objects;
                end
                
                %get the patient with the smallest distance to all other
                %patients in that region
                [~,s] = min(sum(config.data(reps,reps)));
                patient = dataset.extra(reps(s));
                region(rid).Label = patient;
                
                %for ADL the label is the shape of the trajectory, so we
                %would to plot the tarjector within every region
                %first, we need to figure out where to plot the trajectory,
                %for that we need to convert the region centroid to the
                %normalized position relative to the SOM map
                newAxisPos = parentImgPos(1) + parentImgPos(3) * ...
                            (region(rid).Centroid-parentImgAxis(1))/(parentImgAxis(2)-parentImgAxis(1)) - dim./2;
                
                %Boundary condition: 
                %do not let the overlay trajectories go outside the image
                %boundaries, 
                %left and bottom boundaries
                newAxisPos = max(newAxisPos,parentImgPos(1:2));
                
                %right boundary
                if newAxisPos(1)+dim(1) > parentImgPos(1)+parentImgPos(3)
                    newAxisPos(1) = newAxisPos(1) - ((newAxisPos(1)+dim(1)) - (parentImgPos(1)+parentImgPos(3)));
                end
                
                %top boundary
                if newAxisPos(2)+dim(2) > parentImgPos(2)+parentImgPos(4)
                    newAxisPos(2) = newAxisPos(2) - ((newAxisPos(2)+dim(2)) - (parentImgPos(2)+parentImgPos(4)));
                end
 
                %this is the position of the trajector
                %shift the position by half the width and height to make it
                %look more centered in the region
                newAxisPos = [newAxisPos dim];
                
                %plot the trajectory
                h = axes('Position', newAxisPos, 'Layer','top');
                plot(patient.date,patient.score,'-k','LineWidth',2);
                axis(h, 'off', 'tight');
                %set(gca,'YLim',[0 28]);
                
           end
           
       case 'GPD194'
           for r=1:length(regionInd)
                rid = regionInd(r);
                
                %get the indicies for the neurons representing this region 
                neuronInds = find(WS == rid);
                
                %save the coordinates of the neurons belonging to that
                %region
                region(rid).Neurons = coords(neuronInds,:);
                
                %assign the region ID to that neuron
                neuron2region(neuronInds) = rid;
                
                %find the data points belongning to that region, we use the
                %maximum value in the membership matrix to determine which
                %point belongs to which neurons in that region
                region(rid).Objects = find(ismember(object2neuron, neuronInds)==1);
                objectsFound = [objectsFound region(rid).Objects];
       
                %for every neuron get the representive object
                %it is the object with the highest cooefficient
                %
                %for crisp SOM we do not have representives for every
                %neurons since the u{ik} = {0,1} so all objects with
                %membership 1 are representitive of that neuron
                if strcmp(config.mode,'frbsom') || strcmp(config.mode,'fbsom')
                    reps = neuron2object(neuronInds);
                else
                    reps = region(rid).Objects;
                end
                
                genes = unique(dataset.extra(reps));
                title = [];
                for g=1:length(genes)
                   title = [title genes{g} '\newline']; 
                end
                
                %in case the region does not have a label
                if ~isempty(title)
                    regionTitle = sprintf('R%d:%s',rid,title);
                    text(region(rid).Centroid(1),region(rid).Centroid(2),regionTitle,'FontWeight','bold');
                end
            end
            
       otherwise
            for r=1:length(regionInd)
                rid = regionInd(r);
                
                %get the indicies for the neurons representing this region 
                neuronInds = find(WS == rid);
                
                %save the coordinates of the neurons belonging to that
                %region
                region(rid).Neurons = coords(neuronInds,:);
                
                %assign the region ID to that neuron
                neuron2region(neuronInds) = rid;
                
                %find the data points belongning to that region, we use the
                %maximum value in the membership matrix to determine which
                %point belongs to which neurons in that region
                region(rid).Objects = find(ismember(object2neuron, neuronInds)==1);
                objectsFound = [objectsFound region(rid).Objects];
       
                %for every neuron get the representive object
                %it is the object with the highest cooefficient
                %
                %for crisp SOM we do not have representives for every
                %neurons since the u{ik} = {0,1} so all objects with
                %membership 1 are representitive of that neuron
                if strcmp(config.mode,'frbsom') || strcmp(config.mode,'fbsom')
                    reps = neuron2object(neuronInds);
                else
                    reps = region(rid).Objects;
                end
                
                regionTitle = sprintf('R%d',rid);
                
                %if labels are provided for every object
                if isfield(dataset,'u') && ~isempty(dataset.u)
                    %get the label for every representivitive object
                    [~,c] = max(dataset.u(:,reps));
                    
                    %do a histogram for the labels found
                    [N X] = hist(c);
                    X = round(X);
                    
                    %find the label with the highest frequency among
                    %objects of that region
                    [~,labelInd] = max(N);
                
                    %get the label name
                    label = dataset.labels{X(labelInd)};
                    regionTitle = sprintf('R%d:%s',rid,label);
                    
                    region(rid).Label = label;
                end
                
                %add label for this region at the centroid
                text(region(rid).Centroid(1),region(rid).Centroid(2),regionTitle,'FontWeight','bold');
            end
    end
    
    %*************************IMPORTANT************************************
    % Carp, what about boundary neurons? they also have points
    % associated with them, otherwise the total number of objects
    % represented in the regions may not match the same number of
    % objects in the dataset
    %**********************************************************************
    rp = find(ismember(1:length(map.bmu),objectsFound) == 0);
           
    %pairwise distances among neurons
    d = map.codebookDist;
           
    assignedNeurons = find(neuron2region > 0);
           
    %for every remaning patient assigned to a neuron located on the
    %boundary
    for p=1:length(rp)
        %find that neuron index 
        nid = object2neuron(rp(p));
                
        %find the closest neuron assigned to region
        [~,idx] = min(d(nid,assignedNeurons));
                
        %target region
        rid = neuron2region(assignedNeurons(idx));
                
        %add that object/patient the region rid
        region(rid).Objects = [region(rid).Objects rp(p)];
    end
end


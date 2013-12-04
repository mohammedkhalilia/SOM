function dataset = somDatasetStruct(datasetNames)

i = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Congressional Voting Records
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'cvr')) == 1
    data = csvread('Data/CongressionalVotingRecords.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Congressional Voting Records'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'R' 'D'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,2,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Chain Link
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'chainlink')) == 1
    data = csvread('Data/Chainlink.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Chain Link Data Set'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,2,size(data,1));
    i= i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Atom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'atom')) == 1
    data = csvread('Data/Atom.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Atom Data Set'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,2,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Golf Ball
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'golfball')) == 1
    data = csvread('Data/GolfBall.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Golf Ball'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,1,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Engy Time
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'engytime')) == 1
    data = csvread('Data/EngyTime.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Engy Time'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,2,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Hepta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'hepta')) == 1
    data = csvread('Data/FCPS/01FCPSdata/Hepta.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Hepta'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2' '3' '4' '5' '6' '7'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,7,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lsun
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'lsun')) == 1
    data = csvread('FCPS/01FCPSdata/Lsun.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Lsun'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2' '3'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,3,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Target
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'target')) == 1
    data = csvread('Data/Target.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Target'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2' '3' '4' '5' '6'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,6,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Tetra
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'tetra')) == 1
    data = csvread('Data/Tetra.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Tetra'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2' '3' '4'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,4,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Two Diamonds
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'twodiamonds')) == 1
    data = csvread('Data/TwoDiamonds.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Two Diamonds'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,2,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Wing Nut
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'wingnut')) == 1
    data = csvread('Data/WingNut.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Wing Nut'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2'};
    dataset(i).mapsize = [20 20];
    dataset(i).u = sparse(labels,1:size(data,1),1,2,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 Parallel Lines - Vectorial - CLOSE - 300 points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'closelines')) == 1
    range = [-5 5 10 10.5
             -4 4 20 20.5;
             -5.5 5.5 30 30.5];    
    n = 100;
    data = zeros(n*3,2);
    labels = zeros(1,n*3);
    for l=1:3
        x = range(l,1) + (range(l,2)-range(l,1)).*rand(n,1);
        y = range(l,3) + (range(l,4)-range(l,3)).*rand(n,1);
        data((n*l + 1)-n:n*l,:) = [x y];
        labels((n*l + 1)-n:n*l) = l;
    end

    dataset(i).name = '3 Parallel Lines - Close - (300 points)'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2' '3'};
    dataset(i).mapsize = [20 20];
    dataset(i).u =  sparse(labels,[1:size(data,1)],1,3,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 3 Parallel Lines - Vectorial - CLOSE - 300 points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'farlines')) == 1
    range = [-50 50 10 10.5
             -40 40 30 30.5;
             -50.5 50.5 50 50.5];   
    n = 100;
    data = zeros(n*3,2);
    labels = zeros(1,n*3);
    for l=1:3
        x = range(l,1) + (range(l,2)-range(l,1)).*rand(n,1);
        y = range(l,3) + (range(l,4)-range(l,3)).*rand(n,1);
        data((n*l + 1)-n:n*l,:) = [x y];
        labels((n*l + 1)-n:n*l) = l;
    end

    dataset(i).name = '3 Parallel Lines - Far - (300 points)'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'1' '2' '3'};
    dataset(i).mapsize = [20 20];
    dataset(i).u =  sparse(labels,[1:size(data,1)],1,3,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate 3 Gaussian Clouds Well Separated - Vectorial - 6 points
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'gauss6')) == 1
    a=normrnd(repmat([1,1],2,1), 0.1);
    b=normrnd(repmat([1,5],2,1), 0.1);
    c=normrnd(repmat([4,3],2,1), 0.1);

    data = [a;b;c];
    labels = [1*ones(1,2) 2*ones(1,2) 3*ones(1,2)];

    dataset(i).name = '3 Gaussian Clouds - Well Separated (6 points)'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'G1' 'G2' 'G3'};
    dataset(i).mapsize = [20 20];
    dataset(i).u =  sparse(labels,[1:size(data,1)],1,3,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate 3 Gaussian Clouds Well Separated - Vectorial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'ws3g')) == 1
    a=normrnd(repmat([1,1],500,1), 0.1);
    b=normrnd(repmat([1,5],500,1), 0.1);
    c=normrnd(repmat([4,3],500,1), 0.1);

    data = [a;b;c];
    labels = [1*ones(1,500) 2*ones(1,500) 3*ones(1,500)];

    dataset(i).name = '3 Gaussian Clouds - Well Separated (1500 points)'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'G1' 'G2' 'G3'};
    dataset(i).mapsize = [20 20];
    dataset(i).u =  sparse(labels,[1:size(data,1)],1,3,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generate 3 Gaussian Clouds Overalpping - Vectorial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'o3g')) == 1
    a=normrnd(repmat([1,1],500,1), 1);
    b=normrnd(repmat([1,5],500,1), 1);
    c=normrnd(repmat([4,3],500,1), 1);

    data = [a;b;c];
    labels = [1*ones(1,500) 2*ones(1,500) 3*ones(1,500)];

    dataset(i).name = '3 Gaussian Clouds - Overlapping (1500 points)'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'G1' 'G2' 'G3'};
    dataset(i).mapsize = [20 20];
    dataset(i).u =  sparse(labels,[1:size(data,1)],1,3,size(data,1));
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Iris Data - Vectorial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'iris')) == 1
    labels = [1*ones(1,50) 2*ones(1,50) 3*ones(1,50)];
    data = csvread('Data/iris.csv');

    dataset(i).name = 'Iris Data'; 
    dataset(i).data(1) = struct('type','vectorial','x',data);
    dataset(i).data(2) = struct('type','relational','x',squareform(pdist(data,'euclidean')));
    dataset(i).labels = {'IS' 'IV1' 'IV2'};
    dataset(i).mapsize = [11 6];
    dataset(i).u =  sparse(labels,[1:size(data,1)],1,3,size(data,1));
    i = i+1;
end

end

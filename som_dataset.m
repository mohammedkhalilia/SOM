function dataset = som_dataset(datasetNames)

i = 1;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Congressional Voting Records
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'cvr')) == 1
    data = csvread('Data/CongressionalVotingRecords.csv');
    data = data(:,2:end);

    dataset(i).name = 'Congressional Voting Records'; 
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = [repmat({'Republican'},1,168) repmat({'Democrat'},1,267)];
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Hepta
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'hepta')) == 1
    data = csvread('Data/Hepta.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Hepta'; 
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Lsun
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'lsun')) == 1
    data = csvread('Data/Lsun.csv');
    labels = data(:,1);
    data = data(:,2:end);

    dataset(i).name = 'Lsun'; 
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels'));
    dataset(i).mapsize = [20 20];
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
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = cellstr(num2str(labels'));
    dataset(i).mapsize = [20 20];
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

    dataset(i).name = '3 Gaussian Clouds - Well Separated (1500 points)'; 
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = [repmat({'G1'},1,500) repmat({'G2'},1,500) repmat({'G3'},1,500)];
    dataset(i).mapsize = [20 20];
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

    dataset(i).name = '3 Gaussian Clouds - Overlapping (1500 points)'; 
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = [repmat({'G1'},1,500) repmat({'G2'},1,500) repmat({'G3'},1,500)];
    dataset(i).mapsize = [20 20];
    i = i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Iris Data - Vectorial
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if sum(ismember(datasetNames,'iris')) == 1
    data = csvread('Data/iris.csv');

    dataset(i).name = 'Iris Data'; 
    dataset(i).objectData = data;
    dataset(i).relationalData = squareform(pdist(data,'euclidean'));
    dataset(i).labels = [repmat({'Setosa'},1,500) repmat({'Versicolor'},1,500) repmat({'Virginica'},1,500)];
    dataset(i).mapsize = [11 6];
end

end

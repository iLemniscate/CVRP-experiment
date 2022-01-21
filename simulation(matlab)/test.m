clc;
clear;
close all;

%% Initialization

%register node and weight
datasetnode = load('X-n1001-k43-node.txt');
datasetweight = load('X-n1001-k43-weight.txt');
dataset = datasetnode(:,1:3);
dataset(:,4) = datasetweight(:,2);
depot = dataset(1,2:3);

%register truck
nTruck = 43;
truckCap = 131;

%set optimal solution
optSol = 0;

%move depot to 0,0
dataset(:,2) = dataset(:,2)-depot(1,1);
dataset(:,3) = dataset(:,3)-depot(1,2);
antDataset = dataset;

%create distance matrix
n = size(dataset,1);
distMat = zeros(n,n);
for u = 1:n
    for v = u:n
        if (u~=v)
%           x1 = dataset(u,2)-dataset(v,2);
%           x2 = dataset(u,3)-dataset(v,3);
%           distMat(u,v) = norm([x1 x2]);
%           distMat(v,u) = norm([x1 x2]);
            distMat(u,v) = norm(dataset(u,2:3)-dataset(v,2:3));
            distMat(v,u) = distMat(u,v);
        end
    end
end

%remove depot from node list
dataset = dataset(2:size(dataset,1),:);
dataset(:,1) = dataset(:,1) - 1;
n = n-1;

%HEFA properties
gamma = 0.95;
alpha = 0.2;
cr = 0.5;

%init population
nFireflies = 20;
fireflies = zeros(nFireflies,n+1);
bestFirefly(1,1:n) = 0;
bestFirefly(1,n+1) = -inf;

%% Main

%hefa cluster
[truckGroup, dataset, bestResult] = hefaCluster(nTruck, truckCap, n, dataset, 1000);
% plot(bestResult);
color = ['k' 'r' 'g' 'b' 'c' 'm'];
shape = ['o' '^' 's' 'd' 'p' 'h'];

%show result
scatter(0,0,[],'b','x');
hold on;

for i = 1:nTruck
    tempdt = dataset(dataset(:,5)==i,2:3);
    scatter(tempdt(:,1),tempdt(:,2),[],color(mod(i,6)+1),shape(fix(i/6)+1));
    hold on;
end

%dfa vrp
scheduleResult = zeros(nTruck,max(truckGroup(:,1),[],1));
testSchedule = [];
ind = 1;
result = 0;
bestResult = [];
for u=1:nTruck
    for v=2:n+1
        if (truckGroup(u,v) ~=0)
            testSchedule(ind) = truckGroup(u,v);
            ind = ind+1;
        end
    end
    [scheduleResult(u,1:size(testSchedule(:),1)+1), bestResult] = acoTSP(size(testSchedule(:),1), testSchedule, distMat, antDataset, 100);
%     [scheduleResult(u,1:size(testSchedule(:),1)+1), bestResult] = dhefaVrp(size(testSchedule(:),1), testSchedule, distMat, 100);
    result = result + 1/(scheduleResult(u,size(testSchedule(:),1)+1));
    testSchedule = [];
    ind = 1;
end

for u=1:nTruck
    polygonX = 0;
    polygonY = 0;
    for v=1:truckGroup(u,1)
        polygonX = [polygonX, dataset(scheduleResult(u,v),2)];
        polygonY = [polygonY, dataset(scheduleResult(u,v),3)];
    end
    polygonX = [polygonX, 0];
    polygonY = [polygonY, 0];
%     pgon = polyshape(polygonX, polygonY);
%     plot(pgon);
    plot(polygonX, polygonY);
    hold on;
end

disp("Distance result: ");
disp(result);
disp("Available solution: ");
disp(optSol);
disp("Accuracy compare to available solution: ");
disp(((optSol + (optSol - result))/optSol)*100);


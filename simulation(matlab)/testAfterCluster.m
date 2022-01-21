clc;
clear;
close all;

%register node and weight
datasetnode = load('X-n1001-k43-node.txt');
datasetweight = load('X-n1001-k43-weight.txt');
dataset = datasetnode(:,1:3);
dataset(:,4) = datasetweight(:,2);
depot = dataset(1,2:3);

%move depot to 0,0
dataset(:,2) = dataset(:,2)-depot(1,1);
dataset(:,3) = dataset(:,3)-depot(1,2);
antDataset = dataset;

%create distance matrix
nTruck = 43;
n = 1000;
optSol = 72404;
distMat = load('X-n1001-k43-distMat.txt');
truckGroup = load('X-n1001-k43-clusterResult.txt');

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
clc;
clear;
close all;

%initialize dataset
datasetnode = load('JNE-Medan-Node.txt');
datasetweight = load('JNE-Medan-Weight.txt');
dataset = datasetnode(:,1:3);
dataset(:,4) = datasetweight(:,2);
depot = dataset(1,2:3);

defArr1 = load('JNE-Medan-defaultRoute-1.txt');
defArr2 = load('JNE-Medan-defaultRoute-2.txt');
defArr3 = load('JNE-Medan-defaultRoute-3.txt');

optArr1 = load('JNE-Medan-optRoute-1.txt');
optArr2 = load('JNE-Medan-optRoute-2.txt');
optArr3 = load('JNE-Medan-optRoute-3.txt');

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
            distMat(u,v) = norm(dataset(u,2:3)-dataset(v,2:3));
            distMat(v,u) = distMat(u,v);
        end
    end
end

defDist1 = 1/distVrp(defArr1,distMat);
defDist2 = 1/distVrp(defArr2,distMat);
defDist3 = 1/distVrp(defArr3,distMat);
disp('all default distance');
disp([defDist1, defDist2, defDist3]);
disp('total default distance');
disp(defDist1+defDist2+defDist3);

optDist1 = 1/distVrp(optArr1,distMat);
optDist2 = 1/distVrp(optArr2,distMat);
optDist3 = 1/distVrp(optArr3,distMat);
disp('all sweep algorithm distance');
disp([optDist1, optDist2, optDist3]);
disp('total sweep algorithm distance');
disp(optDist1+optDist2+optDist3);

function [ants, pheromMat] = acoTsp1Cycle(nAnts, ants, dim, vaporation, distMat, pheromMat)
    for u = 1:nAnts
        ants(u,:) = zeros(1,dim+2);
        ants(u,1) = 1;
        available = [];
        available(1,:) = 1:dim+1;
        available(2,:) = zeros(1,dim+1) + 1;
        available(2,1) = 0;
        for v = 2:dim+1
            ants(u,v) = findNextNode(ants(u,v-1), available, distMat, pheromMat);
            available(2,ants(u,v)) = 0;
        end
        ants(u,dim+2) = distTsp(ants(u,1:dim+1), distMat);
%         ants(u,:) = localSearch2opt(dim, ants(u,:), distMat);
        pheromMat = updatePheromone(ants(u,:), dim, vaporation, pheromMat);
    end
    ants = sortrows(ants,dim+2);
%     bestAnt = localSearch2opt(dim, bestAnt, distMat);
%     echo on;
%     disp(ants);
%     echo off;
end
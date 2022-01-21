function [ant, bestResult] = acoTSP(dim, sample, distMat, dataset, iteration)
    % dim = firefly dimension
    % cap = truck maximal capacity (number)
    % n = node count (number)
    % nodes = all nodes (n x 4)
    % iteration = iteration (number)
    
    %ACO properties
    vaporation = 0.3;
    pheromMat = zeros(dim+1) + 1;

    sample = sample + 1;
%     echo on;
%     disp(["sample", sample]);
%     echo off;
    %create distMat and pheromMat
    localDistMat = zeros(dim+1);
    for u=2:dim+1
        localDistMat(1,u) = distMat(1,sample(u-1));
        localDistMat(u,1) = distMat(sample(u-1),1);
        for v = u:dim+1
            if (u~=v)
                localDistMat(u,v) = distMat(sample(u-1), sample(v-1));
                localDistMat(v,u) = distMat(sample(v-1), sample(u-1));
            end
        end
    end
    
    %init population
    nAnts = 20;
    ants = zeros(nAnts,dim+2);
    bestAnt(1,1:dim+1) = 0;
    bestAnt(1,dim+2) = -inf;
    
    %init firefly
    for u=1:nAnts
        [ants(u,1:dim+2), pheromMat] = randomMove(dim, vaporation, localDistMat, pheromMat);
    end
    
    ants = sortrows(ants,dim+2);
    if (ants(nAnts,dim+2)>bestAnt(1,dim+2))
        bestAnt = ants(nAnts,:);
    end
    
    %start ACO
    bestResult = [];
    for u=1:iteration
        [ants, pheromMat] = acoTsp1Cycle(nAnts, ants, dim, vaporation, localDistMat, pheromMat);
%         echo on;
%         disp(ants(:,dim+2));
%         echo off;
        if (ants(nAnts,dim+2)>bestAnt(1,dim+2))
%             echo on;
%             disp(["old best", bestAnt]);
            bestAnt = ants(nAnts,:);
%             disp(["new best", bestAnt]);
%             echo off;
        end
        bestResult = [bestResult ants(nAnts,dim+2)];
    end
    
    tangle = 1;
%     while (tangle == 1)
%         tangle = 0;
%         for u = 1:dim-1
%             for v = u+2:dim+1
%                 sampleTemp = [1 sample];
%                 line1 = [];
%                 line2 = [];
%                 line1(1,:) = dataset(sampleTemp(u), 2:3);
%                 line1(2,:) = dataset(sampleTemp(u+1), 2:3);
%                 line2(1,:) = dataset(sampleTemp(v), 2:3);
%                 if (v == dim+1)
%                     line2(2,:) = dataset(sampleTemp(1), 2:3);
%                 else
%                     line2(2,:) = dataset(sampleTemp(v+1), 2:3);
%                 end
%     
%                 if (checkCrossLine(line1,line2)==1)
%                     bestAnt=localSearch2opt(dim, bestAnt, localDistMat);
%                     tangle = 1;
%                     break;
%                 end
% %                 [bestAnt, tangle] = localSearch2opt(dim, u, v, bestAnt, sample, localDistMat, dataset, tangle);
%             end
%             if (tangle == 1)
%                 break;
%             end
%         end
%     end
    
    for t = 1:iteration*dim
        for u = 1:dim-1
            for v = u+2:dim+1
                bestAnt=localSearch2opt(dim, bestAnt, localDistMat);
            end
        end
        
    end
    
    %set best firefly
%     if (ants(nAnts,dim+2)>bestAnt(1,dim+2))
%         bestAnt = ants(nAnts,:);
%     end
    
%     echo on;
%     disp(["best ant", bestAnt]);
%     echo off;
    %convert output
    ant = zeros(1,dim+1);
    for u=2:dim+1
        ant(1,u-1) = sample(1,bestAnt(1,u)-1) - 1;
    end
    ant(1,dim+1) = bestAnt(1,dim+2);
end
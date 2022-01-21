function node = findNextNode(parent, available, distMat, pheromMat)
    nAvailable = sum(available(2,:));
    probVect = zeros(1, nAvailable);
    cumSum = zeros(1, nAvailable);
    nodes = zeros(1, nAvailable);
    ind = 1;
    for u = 1:size(available,2)
        if (available(2,u) == 1)
            nodes(1,ind) = available(1,u);
            ind = ind + 1;
        end
    end
%     echo on;
%     disp(["parent", parent]);
%     disp(nodes);
%     echo off;
    denominator = 0;
    for u = 1:nAvailable
        if (distMat(parent,nodes(1,u)) > 0)
            denominator = denominator + (1/distMat(parent,nodes(1,u))) * pheromMat(parent, nodes(1,u));
        else
            denominator = denominator + (1) * pheromMat(parent, nodes(1,u));
        end
    end
    oldSum = 0;
    roulette = rand;
%     echo on;
%     disp(["roulette", roulette]);
%     echo off;
    for u = 1:nAvailable
        if (distMat(parent,nodes(1,u)) > 0)
            probVect(1,u) = (1/distMat(parent,nodes(1,u))) * pheromMat(parent, nodes(1,u))/denominator;
        else
            probVect(1,u) = (1) * pheromMat(parent, nodes(1,u))/denominator;
        end
        cumSum(1,u) = oldSum + probVect(1,u);
        oldSum = cumSum(1,u);
%         echo on;
%         disp(["cumSum", cumSum(1,u)]);
%         disp(["nominator1", (1/distMat(parent,nodes(1,u)))]);
%         disp(["nominator2", pheromMat(parent, nodes(1,u))]);
%         echo off;
        if (roulette < cumSum(1,u))
            node = nodes(1,u);
            break;
        end
    end
end
function [truckGroup, nodes, bestResult] = hefaCluster(k, cap, n, nodes, iteration)
    % k = cluster count (number)
    % cap = truck maximal capacity (number)
    % n = node count (number)
    % nodes = all nodes (n x 4)
    % iteration = iteration (number)
    
    %HEFA properties
    gamma = 0.9;
    alpha = 0.2;
    cr = 0.5;

    %init population
    nFireflies = 20;
    fireflies = zeros(nFireflies,(k*2)+1);
    bestFirefly(1,1:(k*2)) = 0;
    bestFirefly(1,(k*2)+1) = -inf;
    
    %init result
    truckGroup = zeros(k, 1);
    
    %init cluster
    maxNode = max(nodes(:,2:3),[],1);
    minNode = min(nodes(:,2:3),[],1);
    
    for u=1:nFireflies
        for v=1:k
            fireflies(u,v*2-1) = minNode(1,1)+rand(1,1)*(maxNode(1,1)-minNode(1,1));
            fireflies(u,v*2) = minNode(1,2)+rand(1,1)*(maxNode(1,2)-minNode(1,2));
        end
        fireflies(u,(k*2)+1) = sse(nodes,fireflies(u,1:k*2),k, cap);
    end
    
    fireflies = sortrows(fireflies,(k*2)+1);
    if (fireflies(nFireflies,(k*2)+1)>bestFirefly(1,(k*2)+1))
        bestFirefly = fireflies(nFireflies,:);
    end
    
    %start HEFA
    boundary = [maxNode
        minNode];
    bestResult = [];
    for u=1:iteration
        fireflies = hefaCluster1Cycle(nFireflies, fireflies, k, nodes, alpha, gamma, cr, boundary, cap);
        bestResult = [bestResult fireflies(nFireflies,(k*2)+1)];
        echo on;
        disp(fireflies(:, (k*2)+1));
        echo off;
    end
    
    %set best firefly
    if (fireflies(nFireflies,(k*2)+1)>bestFirefly(1,(k*2)+1))
        bestFirefly = fireflies(nFireflies,:);
    end
    
    %return output
    [nodes(:,5), stuck] = allocateNode(nodes, bestFirefly(1,1:k*2), k, cap);
    
    for u=1:n
        for v=1:k
            if (nodes(u,5)==v)
                truckGroup(v,1) = truckGroup(v,1) + 1;
                truckGroup(v, size(truckGroup(v,:),2)+1) = u;
            end
        end
    end
    
end
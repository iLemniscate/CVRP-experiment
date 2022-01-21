function [allocatedNodes, stuck] = allocateNodeSimple(nodes, centroid, k, cap)
    listNearestNode = zeros(size(nodes,1),k);
    nodes(:,6) = 7;
    stuck = 0;
    empty = [];
    overweight = [];
    
    for u=1:size(nodes,1)
        [nodes(u,5), listNearestNode(u,:), nodes(u,7:6+k)]=findNearestCentroid(nodes(u,2:3),centroid(1,1:k*2),k); 
    end
    
    for u=1:k
        allocatedNode = nodes(nodes(:,5)==u,1:4);
        allocSize = size(allocatedNode(:,1));
        weight = sum(allocatedNode(:,4),1);
        if (weight > cap)
            overweight = [overweight, u];
        end
        if (allocSize(1,1) > 0)
            sumCoord = sum(allocatedNode(:,2:3),1);
            newCentroid = sumCoord/allocSize(1,1);
            centroid(1,(u*2)-1:u*2) = newCentroid;
        else
            empty = [empty, u];
        end
    end
    
    for u=1:size(empty,1)
        random = randi([1 size(overweight,1)],1,1);
        newCentroid = centroid(1,(overweight(random)*2)-1:(overweight(random)*2));
        newCentroid = newCentroid + [newCentroid(1)*rand*0.2, newCentroid(2)*rand*0.2];
        centroid(1, (empty(u)*2)-1:(empty(u)*2)) = newCentroid;
    end
    
    allocatedNodes = nodes(:,5);
end
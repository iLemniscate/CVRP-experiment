function centroid = moveCentroidToCenter(k, centroid, nodes)
    for u=1:k
        allocatedNode = nodes(nodes(:,5)==u,1:4);
        allocSize = size(allocatedNode(:,1));
        if (allocSize(1,1) > 0)
            sumCoord = sum(allocatedNode(:,2:3),1);
            newCentroid = sumCoord/allocSize(1,1);
            centroid(1,(u*2)-1:u*2) = newCentroid;
        end
    end
end
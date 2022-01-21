function f=sse(nodes,centroid,k, cap) 
    % nodes = all node coordinate (n x 3)
    % centroid = all centroid coordinate (1 x k*2)
    % k = cluster count (number)
    % cap = truck maximal capacity (number)
    
    f = 0;
    
    % allocation node
    [nodes(:,5), stuck] = allocateNode(nodes, centroid, k, cap);
%     [nodes(:,5), stuck] = allocateNodeSimple(nodes, centroid, k, cap);
    
    if (stuck == 0)
        % Sum of squared error
        for u=1:k
            allocatedNode = nodes(nodes(:,5)==u,2:3);
            matrixCentroid = repmat(centroid(1,(u*2)-1:u*2),size(allocatedNode(:,1),1),1);
            matrixEuclidian = sqrt(sum((matrixCentroid - allocatedNode(:,1:2)).^2,2));
            matrixEuclidian = matrixEuclidian .* matrixEuclidian;
            f = f + sum(matrixEuclidian,1);
        end
    
        % return fitness
        f = 1/f;
    else
        f = -inf;
    end
end
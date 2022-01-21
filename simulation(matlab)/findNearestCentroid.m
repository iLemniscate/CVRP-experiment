function [f, rankCentroid, rankDist] = findNearestCentroid(node,centroid,k) 
    % node = a node coordinate (1 x 2)
    % centroid = all centroid coordinate (1 x k*2)
    % k = cluster count (number)

    dist = inf;
    listDist = zeros(k,2);
    for u=1:k
        listDist(u,1) = u;
        listDist(u,2) = norm(node-centroid(1,(u*2)-1:u*2));
        if (listDist(u,2)<dist)
            f=u;
            dist=listDist(u,2);
        end
    end
    listDist = sortrows(listDist,2); %sort row ascending
    listDist = listDist.'; %transpose matrix
    rankCentroid = listDist(1,:);
    rankDist = listDist(2,:);
end
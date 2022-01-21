function [ant, pheromMat] = randomMove(dim, vaporation, distMat, pheromMat)
    ant = 2:dim+1;
    
    arrSize = dim;
    for u=1:dim
        ind1 = randi([1 arrSize(1,1)],1,1);
        ind2 = randi([1 arrSize(1,1)],1,1);
        if (arrSize(1,1) > 1)
            while (ind1==ind2)
                ind1 = randi([1 arrSize(1,1)],1,1);
                ind2 = randi([1 arrSize(1,1)],1,1);
            end
        end
        temp = ant(ind1);
        ant(ind1) = ant(ind2);
        ant(ind2) = temp;
    end
    
    ant = [1, ant];
    ant(dim+2) = distTsp(ant(1:dim+1), distMat);
    
    pheromMat = updatePheromone(ant, dim, vaporation, pheromMat);
end
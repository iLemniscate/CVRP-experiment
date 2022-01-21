function pheromMat = updatePheromone(ant, dim, vaporation, pheromMat)
    oldIndex = ant(1);
    for u=2:dim+1
        pheromMat(oldIndex,ant(u)) = ((1-vaporation) * pheromMat(oldIndex,ant(u))) + ant(dim+2);
        pheromMat(ant(u),oldIndex) = ((1-vaporation) * pheromMat(ant(u),oldIndex)) + ant(dim+2);
        oldIndex = ant(u);
    end
    pheromMat(oldIndex,ant(1)) = ((1-vaporation) * pheromMat(oldIndex,ant(1))) + ant(dim+2);
    pheromMat(ant(1),oldIndex) = ((1-vaporation) * pheromMat(ant(1),oldIndex)) + ant(dim+2);
end
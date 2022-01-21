function ant = localSearch2optOld(dist, dim, ant, distMat)
    for u=1:dist
        newAnt = [1, ant];
    
        ind1 = randi([1 dim-1],1,1);
        ind2 = randi([ind1+2 dim+1],1,1);
        swap = zeros(1,ind2-ind1);
        for v = 1:(ind2-ind1)
            swap(v) = newAnt(ind2+1-v);
        end
    
        newAnt(ind1+1:ind2) = swap;
        newAnt(dim+2) = distTsp(newAnt(1:dim+1), distMat);
    
        if (newAnt(dim+2) > ant(dim+2))
            ant = newAnt(2:dim+2);
        end
    end
end
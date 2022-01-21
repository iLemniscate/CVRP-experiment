% function [ant, tangle] = localSearch2opt(dim, ind1, ind2, ant, sample, distMat, dataset, tangle)
function ant = localSearch2opt(dim, ant, distMat)
    newAnt = ant;
    
    ind1 = randi([1 dim-1],1,1);
    ind2 = randi([ind1+2 dim+1],1,1);
    
%     sample = [1 sample];
%     line1 = [];
%     line2 = [];
%     line1(1,:) = dataset(sample(ind1), 2:3);
%     line1(2,:) = dataset(sample(ind1+1), 2:3);
%     line2(1,:) = dataset(sample(ind2), 2:3);
%     if (ind2 == dim+1)
%         line2(2,:) = dataset(sample(1), 2:3);
%     else
%         line2(2,:) = dataset(sample(ind2+1), 2:3);
%     end
%     
%     if (checkCrossLine(line1,line2)==1)
%         tangle = 1;
        swap = zeros(1,ind2-ind1);
        for u = 1:(ind2-ind1)
            swap(u) = newAnt(ind2+1-u);
        end
    
        newAnt(ind1+1:ind2) = swap;
        newAnt(dim+2) = distTsp(newAnt(1:dim+1), distMat);
    
%         ant = newAnt;
        if (newAnt(dim+2) > ant(dim+2))
            ant = newAnt;
        end
%     end
end
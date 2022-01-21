function [firefly, bestResult] = dhefaVrp(dim, fireflySample, distMat, iteration)
    % dim = firefly dimension
    % cap = truck maximal capacity (number)
    % n = node count (number)
    % nodes = all nodes (n x 4)
    % iteration = iteration (number)
    
    %HEFA properties
    gamma = 0.99;
    alpha = 0.1;
    cr = 0.5;

    %init population
    nFireflies = 20;
    fireflies = zeros(nFireflies,dim+1);
    bestFirefly(1,1:dim) = 0;
    bestFirefly(1,dim+1) = -inf;
    
    %init firefly
    for u=1:nFireflies
        fireflies(u,1:dim) = moveDhefaVrp(fireflySample,dim);
        fireflies(u,dim+1) = distVrp(fireflies(u,1:dim), distMat);
    end
    
    fireflies = sortrows(fireflies,dim+1);
    if (fireflies(nFireflies,dim+1)>bestFirefly(1,dim+1))
        bestFirefly = fireflies(nFireflies,:);
    end
    
    %start HEFA
    bestResult = [];
    for u=1:iteration
        fireflies = dhefaVrp1Cycle(nFireflies, fireflies, dim, distMat, alpha, gamma, cr);
%         echo on;
%         disp(fireflies(:,dim+1));
%         echo off;
        bestResult = [bestResult fireflies(nFireflies,dim+1)];
    end
    
    %set best firefly
    if (fireflies(nFireflies,dim+1)>bestFirefly(1,dim+1))
        bestFirefly = fireflies(nFireflies,:);
    end
    
    %return output
    firefly = bestFirefly;
end
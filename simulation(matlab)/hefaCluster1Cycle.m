function fireflies = hefaCluster1Cycle(nFirefly, fireflies, k, nodes, alpha, gamma, cr, boundary, cap)
    n = k*2;
    for u = (nFirefly/2)+1:nFirefly-1
        max = sse(nodes,fireflies(u,1:n),k,cap);
        for v = u+1:nFirefly
            if (max<intensity(fireflies(u,:),fireflies(v,:),n,gamma))
                oldFirefly=fireflies(u,:);
                fireflies(u,1:n) = moveHefaCluster(fireflies(u,1:n),fireflies(v,1:n),n,gamma,alpha,boundary); % fix this
                fireflies(u,n+1) = sse(nodes,fireflies(u,1:n),k,cap);
                if (fireflies(u,n+1)<oldFirefly(n+1))
                    fireflies(u,:)=oldFirefly;
                    %break;
                end
            end
        end
    end
    for u = 1:(nFirefly/2)
        firefly1 = randi([1 nFirefly],1,1);
        firefly2 = randi([1 nFirefly],1,1);
        while (firefly2==firefly1)
            firefly1 = randi([1 nFirefly],1,1);
            firefly2 = randi([1 nFirefly],1,1);
        end
        distFirefly = fireflies(firefly2,1:n)-fireflies(firefly1,1:n);
        crossFirefly = fireflies(u,:);
        for node = 1:n
            if (rand<cr)
                crossFirefly(node) = fireflies(u,node)+distFirefly(1,node);
            end
        end
        if (sse(nodes,fireflies(u,1:n),k,cap)<sse(nodes,crossFirefly(1:n),k,cap))
            crossFirefly(n+1) = sse(nodes,fireflies(u,1:n),k,cap);
            fireflies(u,:)=crossFirefly;
        end
    end
    fireflies = sortrows(fireflies,n+1);
end
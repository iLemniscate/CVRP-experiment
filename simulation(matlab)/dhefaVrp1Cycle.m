function fireflies = dhefaVrp1Cycle(nFirefly, fireflies, dim, distMat, alpha, gamma, cr)
%     for u = (nFirefly/2)+1:nFirefly-1
    for u = 1:nFirefly-1
        max = distVrp(fireflies(u,1:dim),distMat);
        for v = u+1:nFirefly
            if (max<intensityDhefa(fireflies(u,:),fireflies(v,:),dim,gamma))
                oldFirefly=fireflies(u,:);
                dist = fix(actractiveDhefa(fireflies(u,1:dim),fireflies(v,1:dim),dim,gamma));
%                 fireflies(u,1:dim) = moveDhefaVrp(fireflies(u,1:dim),dist);
                fireflies(u,:) = localSearch2optOld(dist, dim, fireflies(u,:), distMat);
%                 fireflies(u,dim+1) = distVrp(fireflies(u,1:dim),distMat);
%                 if (fireflies(u,dim+1)<oldFirefly(dim+1))
%                     fireflies(u,:)=oldFirefly;
%                 end
            end
        end
    end
%     for u = 1:(nFirefly/2)
%         firefly1 = randi([1 nFirefly],1,1);
%         firefly2 = randi([1 nFirefly],1,1);
%         while (firefly2==firefly1)
%             firefly1 = randi([1 nFirefly],1,1);
%             firefly2 = randi([1 nFirefly],1,1);
%         end
%         distFirefly = fireflies(firefly2,1:n)-fireflies(firefly1,1:n);
%         crossFirefly = fireflies(u,:);
%         for node = 1:n
%             if (rand<cr)
%                 crossFirefly(node) = fireflies(u,node)+distFirefly(1,node);
%             end
%         end
%         if (sse(nodes,fireflies(u,1:n),k,cap)<sse(nodes,crossFirefly(1:n),k,cap))
%             crossFirefly(n+1) = sse(nodes,fireflies(u,1:n),k,cap);
%             fireflies(u,:)=crossFirefly;
%         end
%     end
    fireflies = sortrows(fireflies,dim+1);
end
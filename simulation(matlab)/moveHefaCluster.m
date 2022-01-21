function firefly=moveHefaCluster(arr,arr2,k,gamma,alpha,boundary)
    mn = boundary(1,:);
    mx = boundary(2,:);
    temp(1,1:k) = -alpha;
    firefly = arr(1,1:k)+actractive(arr,arr2,k,gamma)*(arr2(1,1:k)-arr(1,1:k))+2*alpha*rand(1,k)+temp;
    for u = 1:k
        if (mod(u,2)==1 && firefly(1,u)>mx(1,1))
            firefly(1,u) = mx(1,1);
        elseif (mod(u,2)==0 && firefly(1,u)>mx(1,2))
            firefly(1,u) = mx(1,2);
        elseif (mod(u,2)==1 && firefly(1,u)<mn(1,1))
            firefly(1,u) = mn(1,1);
        elseif (mod(u,2)==0 && firefly(1,u)<mn(1,2))
            firefly(1,u) = mn(1,2);
        end
    end
end
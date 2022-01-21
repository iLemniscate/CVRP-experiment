function ins=intensity(arr,arr2,n,gamma)
    % calculate intensity arr2 -> arr
    % arr = node (n x 1)
    % arr2 = node (n x 1)
    % n = vector dimension (number)
    % gamma = gamma property from HEFA (number)
    
    ins = arr2(1,n+1)*exp(-gamma*norm(arr2(1,1:n)-arr(1,1:n)));
end
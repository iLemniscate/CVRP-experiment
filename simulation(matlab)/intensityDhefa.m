function ins=intensityDhefa(arr,arr2,n,gamma)
    % calculate intensity arr2 -> arr
    % arr = node (n x 1)
    % arr2 = node (n x 1)
    % n = vector dimension (number)
    % gamma = gamma property from HEFA (number)
    
    ins = arr2(1,n+1)*exp(-gamma*distDim(arr(1:n), arr2(1:n)));
end
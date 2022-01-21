function act=actractive(arr,arr2,n,gamma)
    % calculate actractiveness arr2 -> arr
    % arr = vector(n)
    % arr2 = vector(n)
    % n = vector dimension
    % gamma = gamma property from HEFA
    act = exp(-gamma*(norm(arr2(1,1:n)-arr(1,1:n)).^2));
end
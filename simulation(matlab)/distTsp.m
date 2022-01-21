function f = distTsp(arr,distMat)
    f = 0;
    arrSize = size(arr(:),1);
    oldInd = arr(1);
    for u=2:arrSize(1,1)
        f = f + distMat(oldInd, arr(u));
        oldInd = arr(u);
    end
    f = f + distMat(oldInd, arr(1));
    f = 1/f;
end
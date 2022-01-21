function f=distVrp(arr,distMat)
    f = 0;
    arrSize = size(arr(:),1);
    oldInd = 1;
    for u=1:arrSize(1,1)
        f = f + distMat(oldInd, arr(u)+1);
        oldInd = arr(u)+1;
    end
    f = f + distMat(oldInd, 1);
    f = 1/f;
end
function f=distDim(arr,arr2)
    f = 0;
    arrSize = size(arr(:),1);
    for u=1:arrSize(1,1)
        if (arr(u) ~= arr2(u))
            f = f + 1;
        end
    end
end
function firefly=moveDhefaVrp(arr,dist)
    firefly = arr;
    arrSize = size(arr(:),1);
    for u=1:dist
        dim1 = randi([1 arrSize(1,1)],1,1);
        dim2 = randi([1 arrSize(1,1)],1,1);
        if (arrSize(1,1) > 1)
            while (dim1==dim2)
                dim1 = randi([1 arrSize(1,1)],1,1);
                dim2 = randi([1 arrSize(1,1)],1,1);
            end
        end
        temp = firefly(dim1);
        firefly(dim1) = firefly(dim2);
        firefly(dim2) = temp;
    end
end
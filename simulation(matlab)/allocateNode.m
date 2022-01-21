function [allocatedNodes, stuck] = allocateNode(nodes, centroid, k, cap)
    listNearestNode = zeros(size(nodes,1),k);
    nodes(:,6) = 7;
    stuck = 0;
    
%     for u=1:k
%         allocatedNode = nodes(nodes(:,5)==u,1:4);
%         allocSize = size(allocatedNode(:,1));
%         if (allocSize(1,1) > 0)
%             sumCoord = sum(allocatedNode(:,2:3),1);
%             newCentroid = sumCoord/allocSize(1,1);
%             centroid(1,(u*2)-1:u*2) = newCentroid;
%         end
%     end
    centroid = moveCentroidToCenter(k, centroid, nodes);

    for u=1:size(nodes,1)
        [nodes(u,5), listNearestNode(u,:), nodes(u,7:6+k)]=findNearestCentroid(nodes(u,2:3),centroid(1,1:k*2),k); 
    end
    
    for u=1:k
        allocatedNode = nodes(nodes(:,5)==u,1:4);
        allocSize = size(allocatedNode(:,1));
        weight = sum(allocatedNode(:,4),1);
        indexPickedCount = zeros(1,allocSize(1,1));
        while (weight > cap)
            index = 1;
            minDist = inf;
            for v=1:allocSize(1,1)
                indexNode = allocatedNode(v,1);
                min = abs(nodes(indexNode,7) - nodes(indexNode, nodes(indexNode,6)));
                if ((min < minDist) && (indexPickedCount(1,v)<=k))
                    index = v;
                    minDist = min;
                end
            end
            indexNode = allocatedNode(index,1);
            newAllocInd = listNearestNode(indexNode, nodes(indexNode,6) - 6);
            targetAllocNode = nodes(nodes(:,5)==newAllocInd,1:4);
            targetWeight = sum(targetAllocNode(:,4),1);
            
%             tempWeightList = [];
%             for v=1:k
%                 tempAllocNode = nodes(nodes(:,5)==v,1:4);
%                 tempWeightList = [tempWeightList,  sum(tempAllocNode(:,4),1)];
%             end
%             echo on;
%             disp(["next weight" targetWeight + allocatedNode(index,4)]);
%             disp(tempWeightList);
%             echo off;

            if (targetWeight + allocatedNode(index,4) <= cap)
                nodes(indexNode,5) = newAllocInd;
                nodes(indexNode,7) = nodes(indexNode, nodes(indexNode,6));
                for v=1:allocSize
                    if(allocatedNode(v,1) ~= indexNode)
                        w = find(listNearestNode(allocatedNode(v,1),:)==u);
                        nodes(allocatedNode(v,1),6) = 6 + w;
                    end
                end
                indexPickedCount = zeros(1,allocSize(1,1));
                centroid = moveCentroidToCenter(k, centroid, nodes);
            else
                indexPickedCount(1,index) = indexPickedCount(1,index) + 1;
                if (nodes(indexNode,6) < size(nodes(indexNode,:),2))
                    nodes(indexNode,6) = nodes(indexNode,6) + 1;
                else
                    nodes(indexNode,6) = 7;
                end
            end
            if (sum(indexPickedCount(1,:),2) > allocSize(1,1) * k)
                weight = 0;
                stuck = 1;
            else
                allocatedNode = nodes(nodes(:,5)==u,1:4);
                allocSize = size(allocatedNode(:,1));
                weight = sum(allocatedNode(:,4),1);
            end
        end
    end
    allocatedNodes = nodes(:,5);
end
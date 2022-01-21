function cross = checkCrossLine(line1, line2)
    cross = 0;
    
    x1 = line1(1,1);
    x2 = line1(2,1);
    x3 = line2(1,1);
    x4 = line2(2,1);
    
    y1 = line1(1,2);
    y2 = line1(2,2);
    y3 = line2(1,2);
    y4 = line2(2,2);
    
    x = ((y1-y3)*(x4-x3)*(x2-x1)+x3*(y4-y3)*(x2-x1)-x1*(y2-y1)*(x4-x3))/((y4-y3)*(x2-x1)-(y2-y1)*(x4-x3));
    y = ((x1-x3)*(y4-y3)*(y2-y1)+y3*(x4-x3)*(y2-y1)-y1*(x2-x1)*(y4-y3))/((x4-x3)*(y2-y1)-(x2-x1)*(y4-y3));
    
    maxLine1 = max(line1,[],1);
    minLine1 = min(line1,[],1);
    maxLine2 = max(line2,[],1);
    minLine2 = min(line2,[],1);
    
    insideLine1 = 0;
    if (minLine1(1,1) < x && x < maxLine1(1,1) && minLine1(1,2) < y && y < maxLine1(1,2))
        insideLine1 = 1;
    end
    insideLine2 = 0;
    if (minLine2(1,1) < x && x < maxLine2(1,1) && minLine2(1,2) < y && y < maxLine2(1,2))
        insideLine2 = 1;
    end
    if (insideLine1 == 1 && insideLine2 == 1)
        cross = 1;
    end
    
    echo on;
    disp([x, y, cross]);
    echo off;
    
end
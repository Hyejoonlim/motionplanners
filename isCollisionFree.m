function conf = isCollisionFree(qCurrent, qNext, map)

qCx = qCurrent(1); qCy = qCurrent(2);
qNx = qNext(1); qNy = qNext(2);

% Create a line between the current and next pose
t = 0:0.01:1;
qLinex = (1-t)*qCx + t*qNx; qLiney = (1-t)*qCy + t*qNy;

col = false;

for i = 1:length(qLinex)
    x = qLinex(i); y = qLiney(i);
    if checkOccupancy(map, [x,y]) == 1
            col = true;
            break
    end
end

conf = ~col;

end
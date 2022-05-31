function multipleSearchTree(start, goal, Cobs, l, w)


EnvX = l.*rand(1000,1);
EnvY = w.*rand(1000,1);


map = OccupancyGrid(Cobs, l, w);
hold on
scatter(start(1), start(2), 'filled', 'red')
scatter(goal(1), goal(2), 'filled', 'red')

cont = true;

Ci = 1;
for i = 1:length(EnvY)
    x = EnvX(i); y = EnvY(i);
    if checkOccupancy(map, [x,y]) == 0
        Cfree(Ci,:) = [x, y];
        Ci = Ci+1;
    end
end


path1 = [start(1), start(2)];
path2 = [start(1), start(2)];
path3 = [start(1), start(2)];

qCurrent1 = [start(1), start(2)];
qCurrent2 = [start(1), start(2)];
qCurrent3 = [start(1), start(2)];

k1 = 2; k2 = 2; k3 = 2;

while cont 
    
    % Sample and compute the next pose
    Csamp1 = datasample(Cfree, 100);
    Csamp2 = datasample(Cfree, 100);
    Csamp3 = datasample(Cfree, 100);
  
    qNext1 = nextPose(goal, qCurrent1, path1, Cfree, map, Csamp1);
    qNext2 = nextPose(goal, qCurrent2, path2, Cfree, map, Csamp2);
    qNext3 = nextPose(goal, qCurrent3, path3, Cfree, map, Csamp3);

    % If the algorithm can't find the next pose
    if isempty(qNext1) == 0
        % When the next pose is found add it to the path and plot it
        path1(k1, :) = qNext1;
        plot([path1(k1-1, 1) qNext1(1)], [path1(k1-1, 2), qNext1(2)], 'r--', "LineWidth", 2)
        hold on
        qCurrent1 = [qNext1(1), qNext1(2)];
        k1 = k1+1;
    end
    if isempty(qNext2) == 0
        % When the next pose is found add it to the path and plot it
        path2(k2, :) = qNext2;
        plot([path2(k2-1, 1) qNext2(1)], [path2(k2-1, 2), qNext2(2)], 'g--', "LineWidth", 2)
        hold on
        qCurrent2 = [qNext2(1), qNext2(2)];
        k2 = k2+1;

    end
    if isempty(qNext3) == 0
        % When the next pose is found add it to the path and plot it
        path3(k3, :) = qNext3;
        plot([path3(k3-1, 1) qNext3(1)], [path3(k3-1, 2), qNext3(2)], 'b--', "LineWidth", 2)
        hold on
        qCurrent3 = [qNext3(1), qNext3(2)];
        k3 = k3+1;

    end

    % When the goal is reach within less than 10% deviation
    eps11 = abs((qCurrent1(1) - goal(1))/goal(1));
    eps21 = abs((qCurrent1(2) - goal(2))/goal(2));

    eps12 = abs((qCurrent2(1) - goal(1))/goal(1));
    eps22 = abs((qCurrent2(2) - goal(2))/goal(2));
  
    eps13 = abs((qCurrent3(1) - goal(1))/goal(1));
    eps23 = abs((qCurrent3(2) - goal(2))/goal(2));

    if eps11 < 0.1 && eps21 < 0.1

           path1(k1, :) = [goal(1) goal(2)];
           plot([path1(k1-1, 1) goal(1)], [path1(k1-1, 2), goal(2)], 'r--', "LineWidth", 2)

           cont = false;

    elseif eps12 < 0.1 && eps22 < 0.1

           path1(k2, :) = [goal(1) goal(2)];
           plot([path2(k2-1, 1) goal(1)], [path2(k2-1, 2), goal(2)], 'g--', "LineWidth", 2)

           cont = false;

    elseif eps13 < 0.1 && eps23 < 0.1

           path1(k3, :) = [goal(1) goal(2)];
           plot([path3(k3-1, 1) goal(1)], [path3(k3-1, 2), goal(2)], 'b--', "LineWidth", 2)

           cont = false;

    end

end


end
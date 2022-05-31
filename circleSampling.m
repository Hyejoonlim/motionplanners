function circleSampling (start, goal, Cobs, l, w)

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

qCurrent1 = [start(1), start(2)];


k1 = 2;

while cont 
    
    % Sample and compute the next pose
    t = linspace(0, 2*pi,100);
    ringSampx = qCurrent1(1) + cos(t);
    ringSampy = qCurrent1(2) + sin(t);

    Csamp1 = [ringSampx', ringSampy'];
 
  
    qNext1 = nextPose(goal, qCurrent1, path1, Cfree, map, Csamp1);

    % If the algorithm can't find the next pose
    if isempty(qNext1) == 0
        % When the next pose is found add it to the path and plot it
        path1(k1, :) = qNext1;
        plot([path1(k1-1, 1) qNext1(1)], [path1(k1-1, 2), qNext1(2)], 'r--', "LineWidth", 2)
        hold on
        qCurrent1 = [qNext1(1), qNext1(2)];
        k1 = k1+1;
    end


    % When the goal is reach within less than 10% deviation
    eps11 = abs((qCurrent1(1) - goal(1))/goal(1));
    eps21 = abs((qCurrent1(2) - goal(2))/goal(2));


    if eps11 < 0.1 && eps21 < 0.1

           path1(k1, :) = [goal(1) goal(2)];
           plot([path1(k1-1, 1) goal(1)], [path1(k1-1, 2), goal(2)], 'r--', "LineWidth", 2)

           cont = false;

    end

end


end
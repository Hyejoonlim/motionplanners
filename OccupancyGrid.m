function map = OccupancyGrid(Cobs, l, w)
map = binaryOccupancyMap(l, w);
nf = length(Cobs);
i = 1;
while i < nf

    xmin = Cobs(i, 1); xmax = Cobs(i,2);
    ymin = Cobs(i+1, 1); ymax = Cobs(i+1, 2);

    x = xmin; 
    while x <= xmax
        x = x+1;
        y = ymin;
        while y <= ymax
             y = y+1;
             setOccupancy(map, [x, y], 1)
        end
    end
    
    i = i+2;
end
show(map)
end
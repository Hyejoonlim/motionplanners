function [closest_pts, distance] = distance_to_line_segment(line_segment, robot_position)

rCenterX = robot_position(1);
rCenterY = robot_position(2);


q0x = line_segment(1, 1);
q0y = line_segment(1, 2);
qfx = line_segment(2, 1);
qfy = line_segment(2, 2);

a = (qfy - q0y)/(qfx - q0x);
b = -1;
c = (q0y - a*q0x)/sqrt(a^2 + b^2);
nT = [a b]./sqrt(a^2 + b^2);

d1 = sqrt((rCenterX - q0x)^2 + (rCenterY - q0y)^2);
d2 = sqrt((rCenterX - qfx)^2 + (rCenterY - qfy)^2);
d3 = abs(nT*[rCenterX; rCenterY] + c);


    if d3 < d1 && d3 < d2
        distance = d3;

        F = @(x)[ nT*[x(1); x(2)] + c
                  (rCenterX-x(1))^2+(rCenterY-x(2))^2-d3^2 ];

        x0 = [q0x; q0y];

        q3 = fsolve(F, x0);

        closest_pts(1, 1) = q3(1);
        closest_pts(1, 2) = q3(2);

    else
       if d1 < d2
         distance = d1;
         closest_pts(1, 1) = q0x;
         closest_pts(1, 2) = q0y;

       elseif d2< d1
          distance = d2;
          closest_pts(1, 1) = qfx;
          closest_pts(1, 2) = qfy;
       end 

    end




 end


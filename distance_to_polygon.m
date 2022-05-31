function [closest_pts, distance] = distance_to_polygon(polygon_vertices, robot_position)

sl = size(polygon_vertices);

distance = Inf;


for i = 1:sl(1)-1
    edge_segment = [polygon_vertices(i,:)', polygon_vertices(i+1,:)'];
    [close, dist] = distance_to_edge(edge_segment, robot_position);
    
    if dist < distance
        distance = dist;
        closest_pts = close;
    end
end


function [close, dist] = distance_to_edge(edge_segment, robot_position)

    P = robot_position';
    A = edge_segment(:,1);
    B = edge_segment(:,2);

    AB = B-A;
    AP = P-A;
    BP = P-B;
    
    t = (AB'*AP)/(AB'*AB);

    if t < 0
        dist = norm(AP);
        close = [A(1) A(2)];
    elseif t >=0 && t <= 1
        dist = norm(P - t*AB);
        closex = (1-t)*A(1) + t*B(1);
        closey = (1-t)*A(2) + t*B(2);
        close = [closex, closey];
    else
        dist = norm(BP);
        close = [B(1), B(2)];
    end


end

end
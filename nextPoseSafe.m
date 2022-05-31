function qNext = nextPoseSafe(qf, qCurrent, path, Cfree, Cobs, map, Csamp)
 
  for i = 1:length(Csamp)
     
     % Sample point
     sampX = Csamp(i, 1); sampY = Csamp(i, 2);
     j = 1;
     minDist = 10^13;
    
     while j < length(Cobs)
         obsMinX = Cobs(j,1); obsMaxX = Cobs(j, 2);
         obsMinY = Cobs(j+1,1); obsMaxY = Cobs(j+1, 2);

         [closest_pts, distance] = distance_to_polygon([obsMinX,obsMinY;obsMaxX, obsMinY; obsMaxX, obsMaxY;obsMinX,obsMaxY], [sampX, sampY]);

         if distance < minDist
             minDist = distance;
         end
         j = j+2;
     end
     obsDist(i) = minDist;

 end


 safeDist = maxk(obsDist, 10);
 dClosest = 10^3;

 for i = 1:length(safeDist)

     sDi = safeDist(i);
     
     rowNum = find(obsDist==sDi);

     sampX = Csamp(rowNum, 1); sampY = Csamp(rowNum, 2);

     % Current distance to the goal
     dsamp = sqrt((sampY-qf(2))^2 + (sampX-qf(1))^2 );

     % Points closer to the goal
     if dsamp < dClosest

         qChosen = [ sampX, sampY];
         
         % The chosen point shouldn't already be in the path
         inPath = ismember(qChosen, path, 'rows');

         if  inPath == 0
             
             conf = isCollisionFree(qCurrent, qChosen, map);
             if conf == 1 % Collision free path
               qNext = qChosen;
               
               
             else
                 continue
             end

         end
     else 
         Csamp = datasample(Cfree, 100);
         continue
     end
     dClosest = dsamp;


end
function qNext = nextPose(qf, qCurrent, path, Cfree, map, Csamp)

  qfx = qf(1); qfy = qf(2);
 
 % Current distance to the goal
  dClosest = sqrt((qCurrent(2)-qf(2))^2 + (qCurrent(1)-qf(1))^2 );

 for i = 1:length(Csamp)
     
     % Sample point
     sampX = Csamp(i, 1); sampY = Csamp(i, 2);
     dsamp = sqrt( (sampX - qfx)^2 + (sampY - qfy)^2 );

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
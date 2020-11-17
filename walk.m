function [] = wal                                                                                                                          j,direction)


global m; 

%follow going up
   while ~outOfBounds && ~recur

        % if at top 
       if i + ydisp == 1 
           outOfBounds = true;
        % otherwise draw line above    
       else
           line([j+xdisp,j+xdisp],[dim-(i+ydisp)+1,dim-(i+ydisp+1)+1]);
           m(i-ydisp,j+xdisp) = bitor(m(i-ydisp,j+xdisp),8);
           ydisp = ydisp + 1;
           m(i-ydisp,j+xdisp) = bitor(m(i-ydisp,j+xdisp),3                       2);

       end
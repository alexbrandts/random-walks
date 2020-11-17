% Creates a matching of endpoints of half-cylinder. Draws graphics

function [matching,maxy] = rwcylGfx(pairs,speed)

matching = uint16(zeros(1,2*pairs));

visited = containers.Map();

maxy = 0;
colors = hsv(10);
cindex = 5;
clf; 
scatter(0,0);

for i = 1:2*pairs-1
    
    i
    
    if matching(i) ~= 0
        continue
    end
        
    cindex = mod(cindex,10) + 1;
    c = colors(cindex,:);

    x = 0;
    y = 0;

    key = strcat(num2str(i+x),',',num2str(y)); % x = 0  and y = 0
    visited(key) = 2;  
    y = y + 1;
    key = strcat(num2str(i+x),',',num2str(y)); % x = 0  and y = 1

    if visited.isKey(key)
        visited(key) = visited(key)*5;
    else visited(key) = 5;
    end

    line([i,i],[0,1],'Color',c);

    matched = false;
    while ~ matched

        foundpath = false;
        while ~foundpath

            n = rand();
            key = strcat(num2str(i+x),',',num2str(y));

            if n > 0.75 && mod(visited(key),2) ~= 0

                foundpath = true;
                visited(key) = visited(key)*2;
                y = y + 1;
                key = strcat(num2str(i+x),',',num2str(y));

                if visited.isKey(key)   
                    visited(key) = visited(key)*5;
                else visited(key) = 5;
                end

                line([i+x,i+x],[y-1,y],'Color',c);
                pause(speed);

                maxy = max(maxy,y);

            elseif n > 0.5 && mod(visited(key),3) ~= 0

                foundpath = true;
                visited(key) = visited(key)*3;

                if i + x == 2*pairs 
                    x = 1 - i;

                else
                    x = x + 1;
                end

                line([i+x,i+x-1],[y,y],'Color',c);
                pause(speed);

                key = strcat(num2str(i+x),',',num2str(y));

                if visited.isKey(key)   
                    visited(key) = visited(key)*7;
                else visited(key) = 7;
                end

            elseif n > 0.25 && mod(visited(key),5) ~= 0

                foundpath = true;
                visited(key) = visited(key)*5;

                if y == 1 
                    matched = true;
                end

                line([i+x,i+x],[y,y-1],'Color',c);
                pause(speed); 

                y = y - 1;
                key = strcat(num2str(i+x),',',num2str(y));

                if visited.isKey(key)   
                    visited(key) = visited(key)*2;
                else visited(key) = 2;
                end

            elseif mod(visited(key),7) ~= 0

                foundpath = true; 
                visited(key) = visited(key)*7;

                if i + x == 1
                    x = 2*pairs - i;
                    line([0,1],[y,y],'Color',c);
                    pause(speed);
                else           
                    x = x - 1;
                    line([i+x,i+x+1],[y,y],'Color',c);
                    pause(speed);
                end

                key = strcat(num2str(i+x),',',num2str(y));

                if visited.isKey(key)   
                    visited(key) = visited(key)*3;
                else visited(key) = 3;
                end
            end    
        end 
    end 

    matching(i) = i+x;
    matching(i+x) = i;

end
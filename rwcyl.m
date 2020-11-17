% Creates a matching of endpoints of half-cylinder. No graphics

function [matching,maxy] = rwcyl(pairs)

matching = uint16(zeros(1,2*pairs));
maxy = 0;
visited = containers.Map();

for i = 1:2*pairs-1
    
    if matching(i) ~= 0
        continue
    end
        
    x = 0;
    y = 0;

    key = strcat(num2str(i+x),',',num2str(y)); % x = 0  and y = 0 here
    visited(key) = 2;  
    y = y + 1;
    key = strcat(num2str(i+x),',',num2str(y)); % x = 0  and y = 1 here

    if visited.isKey(key)
        visited(key) = visited(key)*5;
    else visited(key) = 5;
    end

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
                
                maxy = max(maxy,y);

            elseif n > 0.5 && mod(visited(key),3) ~= 0

                foundpath = true;
                visited(key) = visited(key)*3;

                if i + x == 2*pairs 
                    x = 1 - i;
                else
                    x = x + 1;
                end

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
                else           
                    x = x - 1;
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
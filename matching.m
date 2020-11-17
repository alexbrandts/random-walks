% Creates a matching of endpoints of half-cylinder. No graphics

function [matching,maxy] = matching(pairs)

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
    visited(key) = 1;  
    y = y + 1;
    key = strcat(num2str(i+x),',',num2str(y)); % x = 0  and y = 1 here

    if visited.isKey(key)
        visited(key) = bitor(visited(key),4);
    else visited(key) = 4;
    end

    matched = false;
    while ~ matched

        foundpath = false;
        while ~foundpath

            n = rand();
            key = strcat(num2str(i+x),',',num2str(y));

            if n < 0.25 && ~(bitand(visited(key),1) == 1)

                foundpath = true;
                visited(key) = bitor(visited(key),1);
                y = y + 1;
                key = strcat(num2str(i+x),',',num2str(y));

                if visited.isKey(key)   
                    visited(key) = bitor(visited(key),4);
                else visited(key) = 4;
                end
                
                maxy = max(maxy,y);

            elseif 0.25 <= n && n < 0.5 && bitand(visited(key),2) ~= 2

                foundpath = true;
                visited(key) = bitor(visited(key),2);

                if i + x == 2*pairs 
                    x = 1 - i;
                else
                    x = x + 1;
                end

                key = strcat(num2str(i+x),',',num2str(y));

                if visited.isKey(key)   
                    visited(key) = bitor(visited(key),8);
                else visited(key) = 8;
                end

            elseif 0.5 <= n && n < 0.75 && bitand(visited(key),4) ~= 4

                foundpath = true;
                visited(key) = bitor(visited(key),4);

                if y == 1 
                    matched = true;
                end

                y = y - 1;
                key = strcat(num2str(i+x),',',num2str(y));

                if visited.isKey(key)   
                    visited(key) = bitor(visited(key),1);
                else visited(key) = 1;
                end

            elseif 0.75 <= n && n < 1 && bitand(visited(key),8) ~= 8

                foundpath = true; 
                visited(key) = bitor(visited(key),8);

                if i + x == 1
                    x = 2*pairs - i;
                else           
                    x = x - 1;
                end

                key = strcat(num2str(i+x),',',num2str(y));

                if visited.isKey(key)   
                    visited(key) = bitor(visited(key),2);
                else visited(key) = 2;
                end
            end    
        end 
    end 

    matching(i) = i+x;
    matching(i+x) = i;

end
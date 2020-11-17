function [] = rwpallGfx(dim,speed)

m = ones(dim,dim);

clf; hold on;
scatter(0,0)
xlim([0,dim])
ylim([0,dim])

colors = hsv(10);
count = [0,0,0,0];  
cindex = 0;
for i = 1:dim
    for j = 1:dim
     
        if m(i,j) == 210
            continue
        end
            
        cindex = mod(cindex,10) + 1;
        c = colors(cindex,:);

        num = 0;
        x = 0;
        y = 0;
        recur = false;
        
        while ~recur

            foundpath = false;

            while ~foundpath

                n = rand();

                if n > 0.75 && mod(m(i-y,j+x), 2) ~= 0
                    count(1) = count(1)+1;
                    foundpath = true;
                    m(i-y,j+x) = m(i-y,j+x) * 2;

                    %Graphics
                    line([j+x,j+x],[i-y,i-y-1],'Color',c);
                    pause(speed);
                    %

                    if i - y == 1    
                        y = i - dim;
                    else
                        y = y + 1;
                    end

                    m(i-y,j+x) = m(i-y,j+x) * 5;

                elseif n > 0.5 && mod(m(i-y,j+x), 3) ~= 0
                    
                    count(2) = count(2)+1;
                    foundpath = true;
                    m(i-y,j+x) = m(i-y,j+x) * 3;

                    if j + x == dim
                        x = 1 - j;
                    else
                        x = x + 1;
                    end

                    m(i-y,j+x) = m(i-y,j+x) * 7;
                    %
                    line([j+x-1,j+x],[i-y,i-y],'Color',c);
                    pause(speed);
                    %

                elseif n > 0.25 && mod(m(i-y,j+x), 5) ~= 0
                    
                    count(3) = count(3)+1;
                    foundpath = true;
                    m(i-y,j+x) = m(i-y,j+x) * 5;

                    if i - y == dim
                        y = i - 1; 
                    else
                        y = y - 1;
                    end

                    m(i-y,j+x) = m(i-y,j+x) * 2;
                    %
                    line([j+x,j+x],[i-y-1,i-y],'Color',c);                  
                    pause(speed);
                    %

                elseif mod(m(i-y,j+x), 7) ~= 0

                    count(4) = count(4)+1;
                    foundpath = true; 
                    m(i-y,j+x) = m(i-y,j+x) * 7;
                    %
                    line([j+x,j+x-1],[i-y,i-y],'Color',c);
                    pause(speed);
                    %

                    if j + x == 1
                        x = dim - j;
                    else           
                        x = x - 1;
                    end

                    m(i-y,j+x) = m(i-y,j+x) * 3; 

                end    
            end

            num = num + 1;
            if (x == 0 && y == 0)
                display('Walk returned to the beginning after');
                display(num)
                display('steps');
                recur = true;
            end
        end   
    end
end

count

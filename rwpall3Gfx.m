function [] = rwpall3Gfx(dim,speed)

clf; 
scatter3(0,0,0)
xlim([0,dim])
ylim([0,dim])
zlim([0,dim])

colors = hsv(10);
cindex = 5;


m = ones(dim,dim,dim);

for i = 1:dim
    for j = 1:dim
        for k = 1:dim

            if m(i,j,k) == 30030
                continue
            end
            
            cindex = mod(cindex,10) + 1;
            c = colors(cindex,:);

            x = 0;
            y = 0;
            z = 0;
            recur = false;

            while ~recur

                foundpath = false;

                while ~foundpath

                    n = rand()*1.5;

                    if n > 1.25 && mod(m(i-y,j+x,k+z), 11) ~= 0 %increasing z direction

                        foundpath = true;
                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 11;

                        if k + z == dim
                            z = 1 - k;
                        else
                            z = z + 1;
                        end

                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 13;
                        
                        %
                        line([j+x,j+x],[i-y,i-y],[k+z-1,k+z],'Color',c);
                        pause(speed);
                        %

                    elseif n > 1.25 && mod(m(i-y,j+x,k+z), 13) ~= 0 %decreasing z direction

                        foundpath = true; 
                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 13;
                        
                        %
                        line([j+x,j+x],[i-y,i-y],[k+z-1,k+z],'Color',c);
                        pause(speed);
                        %

                        if k + z == 1
                            z = dim - k;
                        else           
                            z = z - 1;
                        end

                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 11; 

                    elseif n > 0.75 && mod(m(i-y,j+x,k+z), 2) ~= 0

                        foundpath = true;
                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 2;

                        %
                        line([j+x,j+x],[i-y,i-y-1],[k+z,k+z],'Color',c);
                        pause(speed);
                        %

                        if i - y == 1    
                            y = i - dim;
                        else
                            y = y + 1;
                        end

                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 5;

                    elseif n > 0.5 && mod(m(i-y,j+x,k+z), 3) ~= 0

                        foundpath = true;
                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 3;

                        if j + x == dim
                            x = 1 - j;
                        else
                            x = x + 1;
                        end

                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 7;
                        
                        %
                        line([j+x-1,j+x],[i-y,i-y],[k+z,k+z],'Color',c);
                        pause(speed);
                        %

                    elseif n > 0.25 && mod(m(i-y,j+x,k+z), 5) ~= 0

                        foundpath = true;
                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 5;

                        if i - y == dim
                            y = i - 1; 
                        else
                            y = y - 1;
                        end

                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 2;
                        
                        %
                        line([j+x,j+x],[i-y-1,i-y],[k+z,k+z],'Color',c);                  
                        pause(speed);
                        %

                    elseif mod(m(i-y,j+x,k+z), 7) ~= 0

                        foundpath = true; 
                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 7;
                       
                        %
                        line([j+x,j+x-1],[i-y,i-y],[k+z,k+z],'Color',c);
                        pause(speed);
                        %

                        if j + x == 1
                            x = dim - j;
                        else           
                            x = x - 1;
                        end

                        m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 3; 
                    end    
                end
                recur = (x == 0 && y == 0 && z == 0);
            end
        end
    end
end

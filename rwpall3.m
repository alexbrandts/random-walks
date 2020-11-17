function [loopLengths,numLoops] = rwpall3(dim,iterations)

numLoops = zeros(iterations,1);
loopLengths = zeros(iterations, ceil(0.0256*dim*dim+0.7564*dim) + 100);


for iter = 1:iterations
    
    display(iter)

    m = ones(dim,dim,dim);

    for i = 1:dim
        for j = 1:dim
            for k = 1:dim
            

                if m(i,j,k) == 30030
                    continue
                end

                numLoops(iter) = numLoops(iter) + 1;
                loopLengths(iter,numLoops(iter)) = 0;
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
                        
                        
                        elseif n > 1.25 && mod(m(i-y,j+x,k+z), 13) ~= 0 %decreasing z direction

                            foundpath = true; 
                            m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 13;

                            if k + z == 1
                                z = dim - k;
                            else           
                                z = z - 1;
                            end

                            m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 11; 

                        elseif n > 0.75 && mod(m(i-y,j+x,k+z), 2) ~= 0

                            foundpath = true;
                            m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 2;

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

                        elseif n > 0.25 && mod(m(i-y,j+x,k+z), 5) ~= 0

                            foundpath = true;
                            m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 5;

                            if i - y == dim
                                y = i - 1; 
                            else
                                y = y - 1;
                            end

                            m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 2;

                        elseif mod(m(i-y,j+x,k+z), 7) ~= 0

                            foundpath = true; 
                            m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 7;

                            if j + x == 1
                                x = dim - j;
                            else           
                                x = x - 1;
                            end

                            m(i-y,j+x,k+z) = m(i-y,j+x,k+z) * 3; 
                        end    
                    end

                    loopLengths(iter,numLoops(iter)) = loopLengths(iter,numLoops(iter)) + 1;
                    recur = (x == 0 && y == 0 && z == 0);
                end
            end
        end
    end
end
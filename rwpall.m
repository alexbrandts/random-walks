function [loopLengths,numLoops] = rwpall(dim,iterations)

numLoops = zeros(iterations,1);
loopLengths = zeros(iterations,ceil(0.0256*dim*dim+0.7564*dim) + 100);

for i = 1:iterations
    
    display(i)

    m = ones(dim,dim);

    for j = 1:dim
        for k = 1:dim

            if m(j,k) == 210
                continue
            end
                
            numLoops(i) = numLoops(i) + 1;
            loopLengths(i,numLoops(i)) = 0;
            x = 0;
            y = 0;
            recur = false;

            while ~recur

                foundpath = false;

                while ~foundpath

                    n = rand();

                    if n > 0.75 && mod(m(j-y,k+x), 2) ~= 0

                        foundpath = true;
                        m(j-y,k+x) = m(j-y,k+x) * 2;

                        if j - y == 1    
                            y = j - dim;
                        else
                            y = y + 1;
                        end

                        m(j-y,k+x) = m(j-y,k+x) * 5;

                    elseif n > 0.5 && mod(m(j-y,k+x), 3) ~= 0

                        foundpath = true;
                        m(j-y,k+x) = m(j-y,k+x) * 3;

                        if k + x == dim
                            x = 1 - k;
                        else
                            x = x + 1;
                        end

                        m(j-y,k+x) = m(j-y,k+x) * 7;

                    elseif n > 0.25 && mod(m(j-y,k+x), 5) ~= 0

                        foundpath = true;
                        m(j-y,k+x) = m(j-y,k+x) * 5;

                        if j - y == dim
                            y = j - 1; 
                        else
                            y = y - 1;
                        end

                        m(j-y,k+x) = m(j-y,k+x) * 2;

                    elseif mod(m(j-y,k+x), 7) ~= 0

                        foundpath = true; 
                        m(j-y,k+x) = m(j-y,k+x) * 7;

                        if k + x == 1
                            x = dim - k;
                        else           
                            x = x - 1;
                        end

                        m(j-y,k+x) = m(j-y,k+x) * 3; 
                    end    
                end

                loopLengths(i,numLoops(i)) = loopLengths(i,numLoops(i)) + 1;
                recur = (x == 0 && y == 0);
            end
        end
    end
end
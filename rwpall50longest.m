function [loopLengths,numLoops] = rwpall50longest(dim,iterations)

numLoops = zeros(iterations,1);
loopLengths = zeros(iterations,50);

for i = 1:iterations
  
    display(i)
    currentLoops = zeros(1,ceil(0.0256*dim*dim+0.7564*dim));
    m = ones(dim,dim);

    for j = 1:dim
        for k = 1:dim

            if m(j,k) == 210
                continue
            end
                
            numLoops(i) = numLoops(i) + 1;
            currentLoops(numLoops(i)) = 0;
            xdisp = 0;
            ydisp = 0;
            recur = false;

            while ~recur

                foundpath = false;

                while ~foundpath

                    n = rand();

                    if n < 0.25 && mod(m(j-ydisp,k+xdisp), 2) ~= 0

                        foundpath = true;
                        m(j-ydisp,k+xdisp) = m(j-ydisp,k+xdisp) * 2;

                        if j - ydisp == 1    
                            ydisp = j - dim;
                        else
                            ydisp = ydisp + 1;
                        end

                        m(j-ydisp,k+xdisp) = m(j-ydisp,k+xdisp) * 5;

                    elseif n >= 0.25 && n < 0.5 && mod(m(j-ydisp,k+xdisp), 3) ~= 0

                        foundpath = true;
                        m(j-ydisp,k+xdisp) = m(j-ydisp,k+xdisp) * 3;

                        if k + xdisp == dim
                            xdisp = 1 - k;
                        else
                            xdisp = xdisp + 1;
                        end

                        m(j-ydisp,k+xdisp) = m(j-ydisp,k+xdisp) * 7;

                    elseif n >= 0.5 && n < 0.75 && mod(m(j-ydisp,k+xdisp), 5) ~= 0

                        foundpath = true;
                        m(j-ydisp,k+xdisp) = m(j-ydisp,k+xdisp) * 5;

                        if j - ydisp == dim
                            ydisp = j - 1; 
                        else
                            ydisp = ydisp - 1;
                        end

                        m(j-ydisp,k+xdisp) = m(j-ydisp,k+xdisp) * 2;

                    elseif n >= 0.75 && n < 1 && mod(m(j-ydisp,k+xdisp), 7) ~= 0

                        foundpath = true; 
                        m(j-ydisp,k+xdisp) = m(j-ydisp,k+xdisp) * 7;

                        if k + xdisp == 1
                            xdisp = dim - k;
                        else           
                            xdisp = xdisp - 1;
                        end

                        m(j-ydisp,k+xdisp) = m(j-ydisp,k+xdisp) * 3; 
                    end    
                end

                currentLoops(numLoops(i)) = currentLoops(numLoops(i)) + 1;
                recur = (xdisp == 0 && ydisp == 0);
            end
        end
    end
    
    temp = sort(currentLoops,'descend');
    loopLengths(i,1:50) = temp(1:50);
    
end
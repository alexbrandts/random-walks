function data = rwp(dim,iterations)

s=dim/2;
data = ones(iterations,1);

for i = 1:iterations
    
    display(i);
    m = ones(dim,dim);
    n = rand();

    if n < 0.25
        m(s,s) = 2;
        m(s-1,s) = 5;
        xdisp = 0; ydisp = 1;

    elseif n < 0.5
        m(s,s) = 3;
        m(s,s+1) = 7;
        xdisp = 1; ydisp = 0;

    elseif n < 0.75
        m(s,s) = 5;
        m(s+1,s) = 2;
        xdisp = 0; ydisp = -1;

    else
        m(s,s) = 7;
        m(s,s-1) = 3;
        xdisp = -1; ydisp = 0;
    end

    recur = false;
    while ~recur

        foundpath = false;
        while ~foundpath

            n = rand();

            if n > 0.75 && mod(m(s-ydisp,s+xdisp), 2) ~= 0

                foundpath = 1;
                m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 2;

                if s - ydisp == 1    
                    ydisp = -1*s;
                else
                    ydisp = ydisp + 1;
                end

                m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 5;

            elseif n > 0.5 && mod(m(s-ydisp,s+xdisp), 3) ~= 0

                foundpath = 1;
                m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 3;

                if s + xdisp == dim
                    xdisp = 1 - s;
                else
                    xdisp = xdisp + 1;
                end

                m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 7;

            elseif n > 0.25 && mod(m(s-ydisp,s+xdisp), 5) ~= 0

                foundpath = 1;
                m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 5;

                if s - ydisp == dim
                    ydisp = s - 1; 
                else
                    ydisp = ydisp - 1;
                end

                m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 2;

            elseif mod(m(s-ydisp,s+xdisp), 7) ~= 0

                foundpath = 1; 
                m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 7;

                if s + xdisp == 1
                    xdisp = s;
                else           
                    xdisp = xdisp - 1;
                end

                m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 3;

            end
        end
        data(i) = data(i) + 1;
        recur =  (xdisp == 0 && ydisp == 0);
    end
end
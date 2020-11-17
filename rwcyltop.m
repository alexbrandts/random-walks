function [loopLengths,numLoops,maxy] = rwcyltop(pairs,iterations)

loopLengths = zeros(iterations,pairs);
numLoops = zeros(iterations,1);
maxy = zeros(2*iterations,1);

for i = 1:iterations
    display(i)

    [m1,maxy1] = rwcyl(pairs);
    [m2,maxy2] = rwcyl(pairs);

    [cloopLengths, cnumLoops] = matchings2loops(m1,m2);
    loopLengths(i,:) = cloopLengths;
    numLoops(i) = cnumLoops;
    
    maxy(2*i-1) = maxy1;
    maxy(2*i) = maxy2;
end
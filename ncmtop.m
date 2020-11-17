function [loopLengths,numLoops] = ncmtop(pairs,iterations)

loopLengths = zeros(iterations,pairs);
numLoops = zeros(iterations,1);

for i = 1:iterations
    display(i)
    m1 = ncmatching(pairs);
    m2 = ncmatching(pairs);

    [cloopLengths, cnumLoops] = matchings2loops(m1,m2);
    loopLengths(i,:) = sort(cloopLengths,'descend');
    numLoops(i) = cnumLoops;

end
function [loopLengths,numLoops] = matchings2loops(m1,m2)

l = length(m1);
loopLengths = zeros(1,l/2);
numLoops = 0;

for i = 1:l - 1
    
    if m1(i) ~= 0
        numLoops = numLoops + 1;
        next1 = i;
    end
    
    while m1(next1) ~= 0
        next2 = m1(next1);
        m1(next1) = 0;
        m1(next2) = 0;
        next1 = m2(next2);
        m2(next1) = 0;
        m2(next2) = 0;
        loopLengths(numLoops) = loopLengths(numLoops) + 2;
    end
end

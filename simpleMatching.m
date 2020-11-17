function [loopLengths,numLoops] = simpleMatching(pairs,iterations)

loopLengths = zeros(iterations,30);
numLoops = zeros(iterations,1);
matchings = zeros(2,2*pairs);
points = [1:2*pairs];

for i = 1:iterations
    display(i)
    for j = 1:2

        points = points(randperm(2*pairs));

        for k = 1:2:2*pairs    
            matchings(j,points(k)) = points(k+1);
            matchings(j,points(k+1)) = points(k);
        end
    end

    [cloopLengths,cnumLoops] = matchings2loops(matchings(1,:),matchings(2,:));
    loopLengths(i,:) = sort(cloopLengths(1:30),'descend');
    numLoops(i) = cnumLoops;
end
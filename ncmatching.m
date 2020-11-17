function ncmatching = ncmatching(pairs)

points = [zeros(1,pairs),ones(1,pairs)];
points = points(randperm(2*pairs));

ncmatching = zeros(1,2*pairs);
stack = zeros(1,pairs);
queue = zeros(1,pairs);
top = 0;
front = 1;
back = 0;

for i = 1:2*pairs
    
    if points(i) == 0
        top = top + 1;
        stack(top) = i;
    else
        if top == 0
            back = back + 1;
            queue(back) = i;
        else
            j = stack(top);
            top = top - 1;
            ncmatching(i) = j;
            ncmatching(j) = i;
        end
    end
end
    
while top ~= 0
    ncmatching(stack(top)) = queue(front);
    ncmatching(queue(front)) = stack(top);
    top = top - 1;
    front = front + 1;
end
    
    
  

    



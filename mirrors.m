p1 = 1/5;
p2 = 1/3;
p3 = 1 - p1 - p2;

rows = 20;
cols = 20;

global m;
m = rand(rows,cols);

m1 = [];
m2 = [];
m3 = [];

for i = 1:rows
    for j = 1:cols
        if m(i,j) < p1
            m1 = cat(1, m1, [rows-i+1,j]);
            m(i,j) = 1;
            
        elseif m(i,j) < p1 + p2
            m2 = cat(1, m2, [rows-i+1,j]);
            m(i,j) = 2;
            
        else 
            m3 = cat(1, m3, [rows-i+1,j]);
            m(i,j) = 4;
        end
    end 
end

m

clf; hold on;
scatter(m1(:,2), m1(:,1),'<');
scatter(m2(:,2), m2(:,1),'>');
scatter(m3(:,2), m3(:,1),'.');
xlim([0,rows]);
ylim([0,cols]);

for i = 1:rows
    for j = 1:cols
        
        % Let walk() decide what color to use. Maybe it can store a matrix
        % of colors as a static (persistent?) variable. Or maybe a list/dict
        % of places where it has begun tracing paths. It could also keep
        % track of loop length and number of loops etc as static
        % variables.
            
        % if there is no path above current point
        if ~(bitand(m(i,j), 8) == 8)
            walk(i,j,1)
        end

        % if there is no path to the right of current point
        if ~(bitand(m(i,j), 16) == 16)
           walk(i,j,2)
        end

        % if there is no path below current point
        if ~(bitand(m(i,j), 32) == 32)
           walk(i,j,3)
        end

        % if there is no path to the left of current point
        if ~(bitand(m(i,j), 64) == 64)
           walk(i,j,4)
        end
     
    end
end





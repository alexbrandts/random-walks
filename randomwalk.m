x=[];
y=[];

dim = 100;
steps = 10000;
speed = 0.01;

m = ones(dim,dim);
s=dim/2;

clf; hold on;
scatter(0,0)
xlim([-1*s,s])
ylim([-1*s,s])

n = rand();

if n < 0.25
    line([0,0],[0,1])
    m(s,s) = 2;
    m(s-1,s) = 5;
    xdisp = 0; ydisp = 1;
    
elseif n < 0.5
    line([0,1],[0,0])
    m(s,s) = 3;
    m(s,s+1) = 7;
    xdisp = 1; ydisp = 0;
    
elseif n < 0.75
    line([0,0],[0,-1])
    m(s,s) = 5;
    m(s+1,s) = 2;
    xdisp = 0; ydisp = -1;
    
else
    line([0,-1],[0,0])
    m(s,s) = 7;
    m(s,s-1) = 3;
    xdisp = -1; ydisp = 0;
end

for i = 1:steps

    flag = false;
    while ~flag
        n = rand();

        if n > 0.75 && mod(m(s-ydisp,s+xdisp), 2) ~= 0
            flag = 1;
            pause(speed);
            line([xdisp,xdisp],[ydisp,ydisp+1],'LineStyle','-');
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 2;
            m(s-ydisp-1,s+xdisp) = m(s-ydisp-1,s+xdisp) * 5;
            ydisp = ydisp + 1;

        elseif n > 0.5 && mod(m(s-ydisp,s+xdisp), 3) ~= 0
            flag = 1;
            pause(speed);
            line([xdisp,xdisp+1],[ydisp,ydisp],'LineStyle','-');
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 3;
            m(s-ydisp,s+xdisp+1) = m(s-ydisp,s+xdisp+1) * 7;
            xdisp = xdisp + 1;

        elseif n > 0.25 && mod(m(s-ydisp,s+xdisp), 5) ~= 0
            flag = 1;
            pause(speed);
            line([xdisp,xdisp],[ydisp,ydisp-1],'LineStyle','-');
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 5;
            m(s-ydisp+1,s+xdisp) = m(s-ydisp+1,s+xdisp) * 2;
            ydisp = ydisp - 1;

        elseif mod(m(s-ydisp,s+xdisp), 7) ~= 0
            flag = 1; 
            pause(speed);
            line([xdisp,xdisp-1],[ydisp,ydisp],'LineStyle','-');
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 7;
            m(s-ydisp,s+xdisp-1) = m(s-ydisp,s+xdisp-1) * 3;
            xdisp = xdisp - 1;
        end
    end
    
    if (xdisp == 0 && ydisp == 0)
        display('Walk returned to the beginning after');
        display(i+1);
        display('steps');
        break
        
    elseif abs(xdisp) >= s-1 || abs(ydisp) >= s-1
        display('Out of bounds after');
        display(i+1);
        display('steps');
        break
    end
end



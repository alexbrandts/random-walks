dim = 100;
steps = 100000;
speed = 0.000001;

m = ones(dim,dim);
s=dim/2;

clf; hold on;
scatter(0,0)
xlim([-1*s,s])
ylim([-1*s,s])

%could be merged into next block
n = rand();
if n < 0.25;
    line([0,0],[0,1],'Color',[1,0,0])
    m(s,s) = 2;
    m(s-1,s) = 5;
    xdisp = 0; ydisp = 1;
    
elseif n < 0.5
    line([0,1],[0,0],'Color',[1,0,0])
    m(s,s) = 3;
    m(s,s+1) = 7;
    xdisp = 1; ydisp = 0;
    
elseif n < 0.75
    line([0,0],[0,-1],'Color',[1,0,0])
    m(s,s) = 5;
    m(s+1,s) = 2;
    xdisp = 0; ydisp = -1;
    
else
    line([0,-1],[0,0],'Color',[1,0,0])
    m(s,s) = 7;
    m(s,s-1) = 3;
    xdisp = -1; ydisp = 0;
end

for i = 1:steps

    flag = false;
    
    while ~flag
        
        n = rand();

        if n > 0.75 mod(m(s-ydisp,s+xdisp), 2) ~= 0
            
            flag = 1;
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 2;
            %
            line([xdisp,xdisp],[ydisp,ydisp+1],'Color',[1-i/steps,i/steps,i/steps]);
            if abs(xdisp) == s
                line([-1*xdisp,-1*xdisp],[ydisp,ydisp+1],'Color',[1-i/steps,i/steps,i/steps]);
            end
            pause(speed);
            %
            
            if s - ydisp == 1    
                ydisp = -1*s;
            else
                ydisp = ydisp + 1;
            end
            
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 5;

        elseif n > 0.5 && mod(m(s-ydisp,s+xdisp), 3) ~= 0
            
            flag = 1;
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 3;
            
            if s + xdisp == dim
                xdisp = 1 - s;
            else
                xdisp = xdisp + 1;
            end
            
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 7;
            %
            line([xdisp-1,xdisp],[ydisp,ydisp],'Color',[1-i/steps,i/steps,i/steps]);
            if abs(ydisp) == s
                line([xdisp-1,xdisp],[-1*ydisp,-1*ydisp],'Color',[1-i/steps,i/steps,i/steps]);
            end
            pause(speed);
            %

        elseif n > 0.25 && mod(m(s-ydisp,s+xdisp), 5) ~= 0
            
            flag = 1;
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 5;
            
            if s - ydisp == dim
                ydisp = s - 1; 
            else
                ydisp = ydisp - 1;
            end
            
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 2;
            %
            line([xdisp,xdisp],[ydisp+1,ydisp],'Color',[1-i/steps,i/steps,i/steps]);
            if abs(xdisp) == s
                line([-1*xdisp,-1*xdisp],[ydisp+1,ydisp],'Color',[1-i/steps,i/steps,i/steps]);
            end
            pause(speed);
            %

        elseif mod(m(s-ydisp,s+xdisp), 7) ~= 0
            
            flag = 1; 
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 7;
            %
            line([xdisp,xdisp-1],[ydisp,ydisp],'Color',[1-i/steps,i/steps,i/steps]);
            if abs(ydisp) == s
                line([xdisp-1,xdisp],[-1*ydisp,-1*ydisp],'Color',[1-i/steps,i/steps,i/steps]);
            end
            pause(speed);
            %
            
            if s + xdisp == 1
                xdisp = s;
            else           
                xdisp = xdisp - 1;
            end
            
            m(s-ydisp,s+xdisp) = m(s-ydisp,s+xdisp) * 3;
            
        end
    end
    
    if (xdisp == 0 && ydisp == 0)
        display('Walk returned to the beginning after');
        display(i+1);
        display('steps');
        break
    end
            
end


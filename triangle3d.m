function [] = triangle3d( data )
%Input: n by 4 matrix of numbers
%First row should contain the values pAB, pBC, and pAC respectively
%The other rows contain the barycentric coordinates a,b,c of a point in the
%triangle with sides 1-pAB, 1-pBC, 1-pAC

AB = 1 - data(1,1);
BC = 1 - data(1,2);
AC = 1 - data(1,3);

[row,~] = size(data);

zs = data(:,4);
zs = zs(2:length(zs));

x1 = 0;
y1 = 0;
    
x2 = AB;
y2 = 0;
    
t = acos((AC*AC+AB*AB-BC*BC)/(2*AB*AC));
h = AC*sin(t);
    
x3 = sqrt(AC*AC-h*h);
y3 = h;

for i = 2:row
    
    a = data(i,1);
    b = data(i,2);
    c = data(i,3);
    
    u = a + b + c;
    
    l1 = a/u;
    l2 = b/u; 
    l3 = c/u;
       
    x = l1*x1 + l2*x2 + l3*x3;
    y = l1*y1 + l2*y2 + l3*y3;
    
    points(i-1,1) = x;
    points(i-1,2) = y;

end

xs = points(:,1);
ys = points(:,2);

scatter3([xs;xs], [ys;ys], [zeros(row-1,1);zs])
zlim([min(0,min(zs)),max(zs)]);
line([x1 x3],[y1 y3],[0,0],'Color','black');
line([x2 x3],[y2,y3],[0,0],'Color','black');

for i = 2:row
    line([xs(i-1),xs(i-1)], [ys(i-1),ys(i-1)], [zs(i-1),0])
end

k = convhull(xs,ys);

for i = 1:length(k)-1
    line([xs(k(i)),xs(k(i+1))], [ys(k(i)),ys(k(i+1))], [zs(k(i)),zs(k(i+1))],'Color','r')
    line([xs(k(i)),xs(k(i+1))], [ys(k(i)),ys(k(i+1))], [0,0],'Color','r','LineStyle','--')
end
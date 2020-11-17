function [] = triangle( data )
%Input: n by 3 matrix of numbers
%First row should contain the values pAB, pBC, and pAC respectively
%The other rows contain the barycentric coordinates a,b,c of a point in the
%triangle with sides 1-pAB, 1-pBC, 1-pAC

AB = 1 - data(1,1);
BC = 1 - data(1,2);
AC = 1 - data(1,3);

[row,~] = size(data);

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
    
scatter(points(:,1), points(:,2))
line([x1 x3],[y1 y3]);
line([x2 x3],[y2,y3]);
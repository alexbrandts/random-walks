function [] = triangle3d2(pXY, data, polygon)

%pXY is a 1x3 matrix of the form [pAB,pBC,pAC]
%data is a nx4 matrix of coordinate triples and heights
%data is a nx4 matrix of coordinate triples and heights that are used to
%make the polygon

AB = 1 - pXY(1);
BC = 1 - pXY(2);
AC = 1 - pXY(3);

[rowd,~] = size(data);
[rowp,~] = size(polygon);

zsd = data(:,4);
zsp = polygon(:,4);

x1 = 0;
y1 = 0;
    
x2 = AB;
y2 = 0;
    
t = acos((AC*AC+AB*AB-BC*BC)/(2*AB*AC));
h = AC*sin(t);
    
x3 = sqrt(AC*AC-h*h);
y3 = h;

%Convert points from barycentric to Cartesian coordinates: data points
for i = 1:rowd
    
    a = data(i,1);
    b = data(i,2);
    c = data(i,3);
    
    u = a + b + c;
    
    l1 = a/u;
    l2 = b/u; 
    l3 = c/u;
       
    x = l1*x1 + l2*x2 + l3*x3;
    y = l1*y1 + l2*y2 + l3*y3;
    
    points(i,1) = x;
    points(i,2) = y;

end

xsd = points(:,1);
ysd = points(:,2);



%Convert points from barycentric to Cartesian coordinates: polygon points

for i = 1:rowp
    
    a = polygon(i,1);
    b = polygon(i,2);
    c = polygon(i,3);
    
    u = a + b + c;
    
    l1 = a/u;
    l2 = b/u; 
    l3 = c/u;
       
    x = l1*x1 + l2*x2 + l3*x3;
    y = l1*y1 + l2*y2 + l3*y3;
    
    points2(i,1) = x;
    points2(i,2) = y;

end

xsp = points2(:,1);
ysp = points2(:,2);


%Draw points on scatter plot, both above plane and on plane
scatter3([xsd;xsp;xsd;xsp], [ysd;ysp;ysd;ysp], [zeros(rowd+rowp,1);zsd;zsp])

%Set limits of vertical scale
zlim([min(0,min([zsd;zsp])),max([zsd;zsp])]);

%Draw sides of triangle
line([x1,x3],[y1,y3],[0,0],'Color','black');
line([x2,x3],[y2,y3],[0,0],'Color','black');

%Connect points with their projections on the plane
for i = 1:rowd
    line([xsd(i),xsd(i)], [ysd(i),ysd(i)], [zsd(i),0])
end
for i = 1:rowp
    line([xsp(i),xsp(i)], [ysp(i),ysp(i)], [zsp(i),0])
end

%Draw polygon and its projection onto the plane. The polygon is sensitive
%to the order of the points

for i = 1:rowp-1
    line([xsp(i),xsp(i+1)], [ysp(i),ysp(i+1)], [zsp(i),zsp(i+1)], 'Color', 'r')
    line([xsp(i),xsp(i+1)], [ysp(i),ysp(i+1)], [0,0], 'Color', 'r','LineStyle','--')
end
line([xsp(rowp),xsp(1)], [ysp(rowp),ysp(1)], [zsp(rowp),zsp(1)], 'Color', 'r')
line([xsp(rowp),xsp(1)], [ysp(rowp),ysp(1)], [0,0], 'Color', 'r','LineStyle','--')
    
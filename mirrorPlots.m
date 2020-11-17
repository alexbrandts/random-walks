% MeanNumberOfLoopsvsGridSize44

nls = zeros(100000,14);
sizes = [64,100,128,200,256,300,400,500,512,600,700,800,900,1000];

for i = 1:14
    nls(:,i) = csvread(strcat('mirrorsNum',num2str(sizes(i)),'_44_44.txt')); % _33_33
end



err = @(x) sum(((x(1).*sizes.^2+x(2).*sizes + x(3) - mean(nls))./(sqrt(var(nls))/sqrt(100000))).^2);
a = fminunc(err,[1,1,0]);
err(a)

%lscov does work here!

clf
hold on
errorbar(sizes,mean(nls), sqrt(var(nls))/sqrt(100000),'o')
lin = 64:1000;
a = lscov([(sizes').^2,sizes',ones(14,1)],mean(nls)',(var(nls).^(-1))');
plot(lin,a(1)*lin.^2+a(2)*lin+a(3))
xlabel('Grid size')
ylabel('Mean number of loops')
title('Mean number of loops for different grid sizes with p1 = p2 = 4/9. 100000 simulations')

[sqrt(var(nls))/sqrt(100000);a(1)*sizes.^2 + a(2)*sizes + a(3) - mean(nls)]


%%%%%%% MeanLengthOfLongestLoopvsGridSize44 %%%%%%%%%%

ls = zeros(100000,14);
sizes = [64,100,128,200,256,300,400,500,512,600,700,800,900,1000];

for i = 1:14
    ls(:,i) = max(sort(csvread(strcat('mirrors',num2str(sizes(i)),'_44_44.txt')),2,'descend'),[],2);
end

err = @(x) sum(((x(1).*sizes.^x(2)+x(3).*sizes.^x(4) - mean(ls))./(sqrt(var(ls))/sqrt(100000))).^2);
a = fminunc(err,[1,2,1,1]);
err(a)

clf; hold on
errorbar(sizes,mean(ls),sqrt(var(ls))/sqrt(100000),'o')
lin = 64:1000;
plot(lin,a(1)*lin.^a(2)+a(3)*lin.^a(4))
xlabel('Grid size')
ylabel('Mean length of longest loop')
title('Mean length of longest loop for different grid sizes with p1 = p2 = 4/9. 100000 simulations')

[sqrt(var(ls))/sqrt(100000);a(1)*sizes.^a(2) + a(3)*sizes.^a(4) - mean(ls)]

a = lscov([(sizes').^2,sizes',ones(14,1)],mean(ls)',(var(ls).^(-1))');



%%%%%%%%%% 3d triangle plots %%%%%%%%%%%

% MeanNumberLoopsVsp1p2. t is 121x4 matrix of data, [p1,p2,number,length]

t = csvread('triangle256.txt');

k = 1;
m = zeros(11,21);
for p1 = 1:11
for p2 = p1:(22-p1)
m(p1,p2) = t(k,3);
k = k + 1;
end
end
b = bar3(m);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
set(gca,'YTickLabel', 0:0.05:0.5)
set(gca,'XTickLabel', 0.05:0.1:1)
xlabel('p_2')
ylabel('p_1')
zlabel('Mean number of Loops')
title('Mean number of loops for various p_1 and p_2 on 256x256 grid. 100000 simulations each')


%%%  MeanLengthLongestVsp1p2. t is 121x4 matrix of data, [p1,p2,number,length]

k = 1;
m = zeros(11,21);
for p1 = 1:11
for p2 = p1:(22-p1)
m(p1,p2) = t(k,4);
k = k + 1;
end
end
b = bar3(m);
for k = 1:length(b)
    zdata = b(k).ZData;
    b(k).CData = zdata;
    b(k).FaceColor = 'interp';
end
set(gca,'YTickLabel', 0:0.05:0.5)
set(gca,'XTickLabel', 0.05:0.1:1)
ylabel('p_1')
xlabel('p_2')
zlabel('Mean length of longest loop')
title('Mean length of longest loop for various p_1 and p_2 on 256x256 grid. 100000 simulations each')


%%%%%%%%%%%%%%%%%%%%%% Length of longest loop for p1 + p2 = 1


sizes = [128,200,256,300,400,500,512,600,700,800,900,1000];

ls5050 = zeros(10000,12);
for i = 1:12
    ls5050(:,i) = max(sort(csvread(strcat('mirrors',num2str(sizes(i)),'_50_50.txt')),2,'descend'),[],2);
end

err = @(x)sum(((x(1).*sizes.^x(2)-mean(ls1090))./(sqrt(var(ls1090))/100)).^2);
a = fminunc(err,[1,1.75]);
err(a)

lin = 100:1000;
clf;hold on
scatter(sizes,mean(ls5050))
plot(lin,a(1)*lin.^a(2))

% Sample    power and error
%
% 1090      1.74900219
%           10.98
%
% 2575      1.75173455 
%           6.29
%
% 3366      1.74999861
%           4.55
%
% 5050      1.75236861
%           10.26  


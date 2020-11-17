
% Plot cdf of loop length for a single rw loop. normalized by grid size
clf;
hold on;
cdfplot(data1000/2000000)
cdfplot(data500/500000)
cdfplot(data300/180000)
cdfplot(data200/80000)
cdfplot(data100/20000)
cdfplot(data50/5000)
cdfplot(data20/800)
xlim([0,1])
legend('1000,0.545','500,0.574','300,0.600','200,0.623','100,0.679','50,0.762','20,0.920','Location','east')



% Plot cdf of loop length for a single rw loop. Not normalized by grid size
clf;
hold on;
cdfplot(data1000)
cdfplot(data500)
cdfplot(data300)
cdfplot(data200)
cdfplot(data100)
cdfplot(data50)
cdfplot(data20)
%xlim([0,1])
legend('1000,30000','500,30000','300,100000','200,100000','100,100000','50,100000','20,100000','Location','east')



save('rwpngdata.mat','data20','data50','data100','data200','data300','data500','data1000')

save('rwpallngdata.mat','loopLengths100','numLoops100','loopLengths200','numLoops200','loopLengths500','numLoops500','loopLengths1000','numLoops1000','-v7.3')


% results
% 1000 0.5453
% 500  0.5737
% 300  0.6000
% 200  0.6230
% 100  0.6789
% 50   0.7615
% 20   0.9200


%grid size vs mean number of loops
scatter([100,200,300,400,500,600,700,800,900,1000],[259,1028,2314,4107,6413,9235,12564,16417,20783,25645])

b1000=transpose(max(transpose(loopLengths1000)));

clf; hold on;
cdfplot(b1000/2000000)
cdfplot(b500/500000)
cdfplot(b200/80000)
cdfplot(b100/20000)
legend('1000,10000','500,40000','200,100000','100,1000000','Location','east')





%cdf of k-th longest loops, normalized by grid length and k

clf
hold on
cdfplot(bsort100(:,10)/2000)
cdfplot(bsort100(:,5)/4000)
cdfplot(bsort100(:,4)/5000)
cdfplot(bsort100(:,3)/6667)
cdfplot(bsort100(:,2)/10000)
cdfplot(bsort100(:,1)/20000)
legend('10th longest','5th longest','4th longest','3rd longest','2nd longest','Longest','Location','east')
title('Empirical CDF: distribution of length of 1st, 2nd, 3rd, 4th, 5th, and 10th longest loop. 100x100 grid, 1000000 simulations')
xlabel('x = (Length of k-th longest loop) / (20000 / k)')
ylabel('CDF(x)')


clf
hold on
cdfplot(bsort1000(:,10)/200000)
cdfplot(bsort1000(:,5)/400000)
cdfplot(bsort1000(:,4)/500000)
cdfplot(bsort1000(:,3)/666667)
cdfplot(bsort1000(:,2)/1000000)
cdfplot(bsort1000(:,1)/2000000)
legend('10th longest','5th longest','4th longest','3rd longest','2nd longest','Longest','Location','east')
title('Empirical CDF: distribution of length of 1st, 2nd, 3rd, 4th, 5th, and 10th longest loop. 1000x1000 grid, 20000 simulations')
xlabel('x = (Length of k-th longest loop) / (2000000 / k)')
ylabel('CDF(x)')












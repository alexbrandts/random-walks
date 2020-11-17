sizes = [64,100,128,200,256,300,400,500,512,600,700,800,900,1000,1024,1500,2000,2048,3000,4096,5000,8192,10000,16384];

sizes2 = [64,128,256,512,1024,2048,4096,8192,16384];
index2 = [1,3,5,9,15,18,20,22,24];

nclc0 = zeros(100000,24);
nclc025 = zeros(100000,24);
nclc05 = zeros(100000,24);
nclc075 = zeros(100000,24);

ncnl0 = zeros(100000,24);
ncnl025 = zeros(100000,24);
ncnl05 = zeros(100000,24);
ncnl075 = zeros(100000,24);

for i = 1:24
    
    nclc0(:,i) = csvread(strcat('ncLongestCycle',num2str(sizes(i)),'_0.0.txt'));
    nclc025(:,i) = csvread(strcat('ncLongestCycle',num2str(sizes(i)),'_0.25.txt'));
    nclc05(:,i) = csvread(strcat('ncLongestCycle',num2str(sizes(i)),'_0.50.txt'));
    nclc075(:,i) = csvread(strcat('ncLongestCycle',num2str(sizes(i)),'_0.75.txt'));

    ncnl0(:,i) = csvread(strcat('ncNumCycles',num2str(sizes(i)),'_0.0.txt'));
    ncnl025(:,i) = csvread(strcat('ncNumCycles',num2str(sizes(i)),'_0.25.txt'));
    ncnl05(:,i) = csvread(strcat('ncNumCycles',num2str(sizes(i)),'_0.50.txt'));
    ncnl075(:,i) = csvread(strcat('ncNumCycles',num2str(sizes(i)),'_0.75.txt'));
    
end


%%%%%%%%%%%%%%%%%%%%%%% plot for many correlations %%%%%%%%%%%%

%length of longest cycle

%a=linspace(-0.85,-0.75,101)';
%a=-1;
a=-0.85;
clf
hold on
plot(nca1024(:,1)*2-1,nca1024(:,4).*1024.^a)
plot(nca2048(:,1)*2-1,nca2048(:,4).*2048.^a)
plot(nca4096(:,1)*2-1,nca4096(:,4).*4096.^a)
plot(nca8192(:,1)*2-1,nca8192(:,4).*8192.^a)
plot(nca16384(:,1)*2-1,nca16384(:,4).*16384.^a)
plot(nca32768(:,1)*2-1,nca32768(:,4).*32768.^a)
plot(nca65536(:,1)*2-1,nca65536(:,4).*65536.^a)
legend('1024','2048','4096','8192','16384','32768','65536')
xlabel('Correlation')
ylabel('Mean length of longest cycle normalized by number of pairs \^ a')
title('Mean length of longest cycle normalized by number of pairs \^ a for various correlations. 10000 simulations')

% number of cycles

a = -1;

clf
hold on
plot(nca1024(:,1)*2-1,nca1024(:,2).*1024.^a)
plot(nca2048(:,1)*2-1,nca2048(:,2).*2048.^a)
plot(nca4096(:,1)*2-1,nca4096(:,2).*4096.^a)
plot(nca8192(:,1)*2-1,nca8192(:,2).*8192.^a)
plot(nca16384(:,1)*2-1,nca16384(:,2).*16384.^a)
plot(nca32768(:,1)*2-1,nca32768(:,2).*32768.^a)
plot(nca65536(:,1)*2-1,nca65536(:,2).*65536.^a)
legend('1024','2048','4096','8192','16384','32768','65536')
xlabel('Correlation')
ylabel('Mean number of cycles normalized by number of pairs \^ a')
title('Mean number of cycles normalized by number of pairs \^ a for various correlations. 10000 simulations')



% MeanLengthLongestCyclevsNumPairs plot of mean length of longest cycle for various numbers of pairs

clf
hold on
plot(sizes,mean(nclc025))
plot(sizes,mean(nclc05))
plot(sizes,mean(nclc075))
plot(sizes,mean(nclc0))
scatter(sizes,mean(nclc025),'black')
scatter(sizes,mean(nclc05),'black')
scatter(sizes,mean(nclc075),'black')
scatter(sizes,mean(nclc0),'black')
legend('-0.5: 1.9987x \^ 0.8282 -0.9441','0: 1.8729x \^ 0.7951 - 0.3909','0.5:1.6738x \^ 0.7518 - 0.5430','-1: 2.8413x \^ 0.5186 - 2.1059')
xlim([0,18000])
xlabel('Number of pairs')
ylabel('Mean length of longest cycle')
title('Mean length of longest cycle vs number of pairs for different correlation values. 100000 simulations')

errorbar(sizes,mean(nclc025),sqrt(var(nclc025)))
errorbar(sizes,mean(nclc05),sqrt(var(nclc05)))
errorbar(sizes,mean(nclc075),sqrt(var(nclc075)))
errorbar(sizes,mean(nclc0),sqrt(var(nclc0)))

w = var(nclc05).^(-1);
f = @(a,x) w.*(a(1)*x.^a(2)+a(3));
a = lsqcurvefit(f,[1,1,0],sizes,mean(nclc05).*w)

w = var(nclc0).^(-1);
a = lscov([ones(24,1),log(sizes')],log(mean(nclc0))',w');


[sqrt(var(nclc05)/100000);a(1)*sizes.^a(2) + a(3) - mean(nclc05)]

lin = linspace(0,18000);
plot(lin,a(1)*lin.^a(2) + a(3))





% MeanNumCyclevsNumPairs plot of mean number of cycles for various numbers of pairs

sizes = [64,100,128,200,256,300,400,500,512,600,700,800,900,1000,1024,1500,2000,2048,3000,4096,5000,8192,10000,16384];

clf
hold on
plot(sizes,mean(ncnl075))
plot(sizes,mean(ncnl05))
plot(sizes,mean(ncnl025))
plot(sizes,mean(ncnl0))
scatter(sizes,mean(ncnl075),'black')
scatter(sizes,mean(ncnl05),'black')
scatter(sizes,mean(ncnl025),'black')
scatter(sizes,mean(ncnl0),'black')
legend('0.5: 0.4269x + 2.1308','0: 0.231x + 2.389','-0.5: 0.0988x + 3.4405','-1: 1.7688x \^ 0.5002 - 0.9537')
xlim([0,18000])
xlabel('Number of pairs')
ylabel('Mean number of cycles')
title('Mean number of cycles vs number of pairs for different correlation values. 100000 simulations')


%errorbar(sizes,mean(ncnl075),sqrt(var(ncnl075))/2)
%errorbar(sizes,mean(ncnl05),sqrt(var(ncnl05))/2)
%errorbar(sizes,mean(ncnl025),sqrt(var(ncnl025))/2)
%errorbar(sizes,mean(ncnl0),sqrt(var(ncnl0))/2)


a = lscov([sizes',ones(24,1)],mean(ncnl05)',(var(ncnl05).^(-1))');
[sqrt(var(ncln05)/100000);a(1)*sizes + a(2) - mean(ncnl05)]

lin = linspace(0,18000);
plot(lin,a(1)*lin + a(2))



% distLengthLongestCycle050

clf
hold on
cdfplot(nclc05(:,24)/sizes(24)/2)
cdfplot(nclc05(:,22)/sizes(22)/2)
cdfplot(nclc05(:,20)/sizes(20)/2)
cdfplot(nclc05(:,18)/sizes(18)/2)
cdfplot(nclc05(:,15)/sizes(15)/2)
cdfplot(nclc05(:,9)/sizes(9)/2)
cdfplot(nclc05(:,5)/sizes(5)/2)
legend('16384','8192','4096','2048','1024','512','256')
xlabel('x = Length of longest cycle / (2 * number of pairs in matching)')
ylabel('CDF(x)')
title('Empirical CDF: Distribution of length of longest cycle in non crossing matching. Correlation = 0. 100000 simulations')



% distNumLoops05

clf
hold on
cdfplot(ncnl05(:,24)/sizes(24))
cdfplot(ncnl05(:,22)/sizes(22))
cdfplot(ncnl05(:,20)/sizes(20))
cdfplot(ncnl05(:,18)/sizes(18))
cdfplot(ncnl05(:,15)/sizes(15))
legend('16384','8192','4096','2048','1024')
xlabel('x = number of cycles / number of pairs in matching')
ylabel('CDF(x)')
title('Empirical CDF: distribution of number of cycles in non crossing matching. Correlation = 0. 100000 simulations')


% longestCycleVsNumCycles0

clf
hold on
scatter(ncnl0(:,24),nclc0(:,24))
scatter(ncnl0(:,20),nclc0(:,20))
scatter(ncnl0(:,15),nclc0(:,15))
legend('16384','4096','1024')
xlabel('Number of Cycles')
ylabel('Length of Longest Cycle')
title('Length of longest cycle vs number of cycles in non crossing matching. Correlation = -1. 100000 simulations.')

% longestCycleVsNumCycles

clf
hold on
scatter(ncnl025(1:10000,24)/sizes(24),nclc025(1:10000,24))
scatter(ncnl05(1:10000,24)/sizes(24),nclc05(1:10000,24))
scatter(ncnl075(1:10000,24)/sizes(24),nclc075(1:10000,24))
scatter(ncnl025(1:10000,20)/sizes(20),nclc025(1:10000,20))
scatter(ncnl05(1:10000,20)/sizes(20),nclc05(1:10000,20))
scatter(ncnl075(1:10000,20)/sizes(20),nclc075(1:10000,20))
scatter(ncnl025(1:10000,15)/sizes(15),nclc025(1:10000,15))
scatter(ncnl05(1:10000,15)/sizes(15),nclc05(1:10000,15))
scatter(ncnl075(1:10000,15)/sizes(15),nclc075(1:10000,15))
xlabel('Number of Cycles / number or pairs in matching')
ylabel('Length of longest cycle')
title('Length of longest cycle vs number of cycles in non crossing matching. 10000 simulations')




%plot mean of kth longest loop in nc matching of 100000 simulations, 1024
%oairs. meanLengthKthLongest1024log

clf
loglog(m0)
hold on
loglog(m001)
loglog(m01)
loglog(m025)
loglog(m05)
loglog(m075)
legend('a = 0', 'a = 0.01', 'a = 0.1. 1:10,718.74,-1.2749', 'a = 0.25. 1:30,525.76,-1.1779', 'a = 0.5. 1:30,375.92,-1.0897', 'a = 0.75. 1:30,257.79,-1.0088')
xlabel('k')
ylabel('Mean length of k-th longest loop')
title('Mean length of k-th longest loop in gluing of two non-crossing matchings. 1024 pairs, 100,000 simulations')
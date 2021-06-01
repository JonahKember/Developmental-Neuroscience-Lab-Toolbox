function [testStat,clust,stringStart,stringEnd] = testStat(a,b)

runningT = zeros(1,size(a,1));
runningP = zeros(1,size(a,1));

for n = 1:size(a,1)
    [~,p,~,t] = ttest2(a(n,:),b(n,:));
    runningT(1,n) = t.tstat;
    runningP(1,n) = p;
end

runningP = double(runningP < .05);
p = find(diff(runningP) == 1);
p2 = find(diff(runningP) == -1);

if runningP(1) == 1
p = [0,p(:)'];
end
if runningP(end) == 1
p2 = [0,p2(:)'];
end

p(2,:) = p2;
strings = find(p(1,:) - p(2,:) < -1);
stringStart = p(1,strings) + 1;
stringEnd = p(2,strings);

clust = zeros(1,length(stringStart));

for n = 1:length(stringStart)
    clust(n) = sum(runningT(stringStart(n):stringEnd(n)));
end

if clust > 0
    testStat = max(clust);
else
    testStat = 0;
end
end
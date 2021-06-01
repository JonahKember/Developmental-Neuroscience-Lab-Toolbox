function ttestRunning(a,b,per,p_val)

tic
if size(a,1) ~= size(b,1)
disp('Error: Inputs are different lengths!')
end

[~,empiricalClust,stringStart,stringEnd] = testStat(a,b);

testClust = zeros(1,per);

for n = 1:per
[shuffA,shuffB] = shuffleData(a,b);
s = testStat(shuffA,shuffB);
testClust(n) = s;
end

sigVal = prctile(testClust,(100-(p_val*100)));

for n = 1:length(empiricalClust)
    if sigVal < abs(empiricalClust(n))
        fprintf('\n Significant Effect(s)! \n From: %d to %d\n',stringStart(n),stringEnd(n))
    end
end
toc
end
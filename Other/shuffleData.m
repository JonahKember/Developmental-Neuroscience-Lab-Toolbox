function [shuffA, shuffB] = shuffleData(a,b)
randPer = [a,b];
randPer = randPer(randperm(size(randPer,1)),:);
num = size(randPer,2)/2;
shuffA = randPer(:,1:num);
shuffB = randPer(:,(num + 1):end);
end
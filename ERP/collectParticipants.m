function [allSubjCond1,allSubjCond2] = collectParticipants(subjNums,fileLocationCond1,fileLocationCond2)

nSubj = length(subjNums);
allSubjCond1 = zeros(1,nSubj);
allSubjCond2 = zeros(1,nSubj);

for s = 1:nSubj
   inputfileCond1 = @(id)fileLocationCond1; 
   inputfileCond2 = @(id)fileLocationCond2;
   allSubjCond1{s} = load(inputfileCond1(subjNums{s})); 
   allSubjCond2{s} = load(inputfileCond2(subjNums{s}));
end
end
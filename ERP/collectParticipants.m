function [allSubjCond1,allSubjCond2] = collectParticipants(subjects,fileNameCond1,fileNameCond2)

nSubj = length(subjects);

for s = 1:nSubj
   erpCond1 = struct2cell(load(fileNameCond1(subjects{s}))); 
   allSubjCond1{s} = erpCond1{1, 1};
   
   erpCond2 = struct2cell(load(fileNameCond2(subjects{s}))); 
   allSubjCond2{s} = erpCond2{1, 1};
 end
end

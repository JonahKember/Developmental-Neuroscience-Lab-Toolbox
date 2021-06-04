function GA = grandAverageERP(allSubj)

GA = allSubj{1,1}.avg;

for n = 2:length(allSubj)
 GA = GA + allSubj{1,n}.avg;
end
GA.label = allSubj{1,1}.label;
GA = GA/length(allSubj);
end

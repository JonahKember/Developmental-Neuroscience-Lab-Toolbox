function [allSubjCond1,allSubjCond2] = collectParticipants(fileLocation,cond1,cond2)

directory = struct2cell(dir(fileLocation));

for n = 1:length(directory)
    TF(n) = contains(directory(1,n),'.mat');
end

filenames = directory(1,find(TF == 1)); %#ok<FNDSB>

condition1 = [];
condition2 = [];

if contains(cond2,cond1)
    for n = 1:length(filenames)
        if contains(filenames(n),cond1)
            if ~contains(filenames(n),cond2)
            condition1 = [condition1,filenames(n)]; %#ok<*AGROW>
            end
        end
        if contains(filenames(n),cond2) 
        condition2 = [condition2,filenames(n)];
        end
    end
end

if contains(cond1,cond2)
    for n = 1:length(filenames)
        if contains(filenames(n),cond2)
            if ~contains(filenames(n),cond1)
            condition2 = [condition2,filenames(n)];
            end
        end
        if contains(filenames(n),cond1) 
        condition1 = [condition1,filenames(n)];
        end
    end
end

if ~contains(cond1,cond2)
   if ~contains(cond2,cond1)
    for n = 1:length(filenames)
        if contains(filenames(n),cond1)
            condition1 = [condition1,filenames(n)];
        end
        if contains(filenames(n),cond2) 
        condition2 = [condition2,filenames(n)];
        end
    end
   end
end

for s = 1:length(condition1)
    allSubjCond1{1,s} = load(condition1{s});
end

for s = 1:length(condition2)
   allSubjCond2{1,s} = load(condition2{s});
end
end

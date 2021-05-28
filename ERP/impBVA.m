function  impBVA(fileLocation) 

d = dir(fileLocation);
directory = struct2cell(d);

for n = 1:length(directory)
    TF(n) = contains(directory(1,n),'.seg');
end

seg = find(TF == 1);
filenames = directory(1,seg);

for n = 1:length(filenames)
    filename = [fileLocation,'\',filenames{n}];
    filename = filename(1:length(filename)-4);
    data = BVA2Matlab(filename);
    save(filename,'data')
end
end

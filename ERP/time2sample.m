function sample = time2sample(time,data)

sample = zeros(1,length(time));

for n = 1:length(time)
    int = data.time(2) - data.time(1);
    sample(n) = length(data.time(1):int:time(n)) + 1;
end

end
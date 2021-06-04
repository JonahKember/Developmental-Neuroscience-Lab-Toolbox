function channels = channelIndex(c,data)

channels = zeros(1,length(c));

for n = 1:length(c)
channels(n) = find(contains(data.label, c{n}));
end

end
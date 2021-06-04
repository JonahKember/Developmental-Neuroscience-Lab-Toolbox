function data = selectData(cfg,data)

if ~isnumeric(cfg.channel)
    cfg.channel = channelIndex(cfg.channel,data);
end

if contains(cfg.latencyType,'time')
    cfg.latency = time2sample(cfg.latency,data);
end

if ~isempty(cfg.freq)
    data = mean(data.powspctrm(cfg.channel,cfg.freq(1):cfg.freq(2),cfg.latency(1):cfg.latency(2)),'all');
else
    data = mean(data.avg(cfg.channel,cfg.latency(1):cfg.latency(2)),'all');
end
fprintf('\n Selected Data = %.3f \n\n',data)
end

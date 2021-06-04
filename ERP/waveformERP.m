function  waveformERP(cfg,GACond1,GACond2)

if ~isnumeric(cfg.channels)
    cfg.channels = channelIndex(cfg.channel,GACond1);
end

if contains(cfg.colour,'yes')
    plot(GACond1.time,mean(GACond1.avg(cfg.channels,:),1))
    hold on
    plot(GACond1.time,mean(GACond2.avg(cfg.channels,:),1))
else
    plot(GACond1.time,mean(GACond1.avg(cfg.channels,:),1),'k')
    hold on
    plot(GACond1.time,mean(GACond2.avg(cfg.channels,:),1),'k','LineStyle','-');
end

if contains(cfg.labels,'yes')
xlabel('Time (ms)')
ylabel ('Voltage (uV)')
end

if contains(cfg.legend,'yes')
legend(cfg.condNames{1},cfg.condNames{2})
end
ylim(cfg.ylim)

if contains(cfg.highlightEffect,'yes')
    for n = 1:size(cfg.effect,1)
        rectangle('Position',[cfg.effect(n,1) cfg.ylim(1) (cfg.effect(n,2) - cfg.effect(n,1))  (cfg.ylim(2) - cfg.ylim(1))])
    end
end

end

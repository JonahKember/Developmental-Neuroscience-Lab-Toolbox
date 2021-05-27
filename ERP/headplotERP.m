function headplotERP(stat,lay)

cfg = [];
cfg.alpha = .05;
cfg.layout = lay;
cfg.size = [1 1];
cfg.zlim = [-3 3];    % Voltage range for head map colouring

ft_clusterplot(cfg, stat);
end
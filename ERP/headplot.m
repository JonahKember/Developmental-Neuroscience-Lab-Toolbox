function headplot(stat,layout)

layout = layout.layout;
cfg = [];
cfg.alpha = .05;
cfg.layout = layout;
cfg.size = [1 1];
cfg.zlim = [-3 3];    % Voltage range for head map colouring

ft_clusterplot(cfg, stat);
end
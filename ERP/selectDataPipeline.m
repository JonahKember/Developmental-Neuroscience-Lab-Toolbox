%% Select Data
%
%   For either ERPs or power, average across the specified dimensions.
%

cfg.channel = {'Oz','Pz','FCz'};                       % Channels to be averaged across. Can be labels or numbers (i.e., [12,13,14,15]).
cfg.latency = [.350 .550];                             % Time window to be averaged across. Can be in samples or time (specify below).
cfg.freq = [8 12];                                     % Frequency range to be averaged across. Assumes data is ERP format if left blank.
cfg.latencyType = 'time';                              % Is cfg.latency specified in 'time'? Can also be 'sample'.
    
data = selectData(cfg,data);

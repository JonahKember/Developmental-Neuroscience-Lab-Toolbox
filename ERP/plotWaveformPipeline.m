%% Plot Grand Averaged Waveforms

GACond1 = grandAverageERP(Cond1);
GACond2 = grandAverageERP(Cond2);

cfg = [];
cfg.channels =           [12,14,15,16,17,18];                    % Channels to be averaged across in plot. Can also be channel names: {'POz','FCz','Cz'}
cfg.ylim =               [-10 10];                               % [Min Max] y-axis limit (Voltage).
cfg.colour =             'yes';                                  % Plot in colour or in black ('yes'/'no').
cfg.labels =             'yes';                                  % Include labels or not ('yes'/'no').
cfg.legend =             'no';                                   % Include legend or not ('yes'/'no').    
cfg.condNames =          {'Condition 1', 'Condition 1'};         % Names to be included in Legend.
cfg.highlightEffect =    'yes';                                  % Include box around time window.
cfg.effect =             [.2 .5;.6 .7];                          % Time window(s) for boxes.

waveformERP(cfg,GACond1,GACond2)

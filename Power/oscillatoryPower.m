function timeFreq = oscillatoryPower(data,freq)
%
%   Time-frequency analysis of single-trial EEG data. Returns oscillatory power over time, 
%   relative to a baseline from -500 to -200ms, for specified frequencies.
%   
%   INPUTS
%   
%       data       =    Single trial EEG data, as obtained from BVA2Matlab.
%       freq       =    Frequencies used in analysis. [1:1:90] recommended (specific bands can be analyzed independently in powerStats function)
%
%   OUTPUT
%
%       timeFreq   =    Oscillatory power data. 'timeFreq.powspctrm' is a [Channel X Frequency X Time] matrix.       
%
% **Note: Fieldtrip required
%
%% 
cfg = [];
cfg.method = 'wavelet';
cfg.channel = 'all';
cfg.trials = 'all';
cfg.width = 5; 
cfg.output = 'pow'; 
cfg.foi = freq; 
cfg.toi = data.time{1,1};

power = ft_freqanalysis(cfg, data);

cfg = [];
cfg.baseline = [-.5 -.2];
cfg.baselinetype = 'db';
cfg.parameter = 'powspctrm';

timeFreq = ft_freqbaseline(cfg, power);
end

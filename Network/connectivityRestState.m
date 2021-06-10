function adjmat = connectivityRestState(subjdat,freqRange,srate,directed)
%       
%   Use the phase-lag index (PLI) to analyze connectivity between EEG sensors. To analyze PLI for resting state data, use the time-series of phase differences within
%   each trial (phase difference between two signals at each time point) as an input into PLI calculations.
%
%   INPUT:
%
%               subjdat    =    Preprocessed single trial data in a fieldtrip structure, as obtained from ft_preprocessing (or BVAtoMatlab).
%               freqRange  =    Vector with frequency-bands to be used in analyses (i.e. [1 3; 4 7; 8 12; 13 30; 31 90]).
%               srate      =    Sampling rate in Hz.
%               directed   =    0 = Phase-Lag Index (PLI, Default); 1 = Directed Phase-Lag Index(dPLI)
%
%   OUTPUT:
%
%               adjmat     =    [Node X Node X Time X Frequency-band] Adjacency matrices over time for each frequency band.     
%
%%
tic

p.prefilter = @(ts) zscore(ts);
p.filterfn = @(b,a,ts) filter(b,a,ts);
maxn = 0;

for fq = 1:length(freqRange)
  filtband = freqRange(fq,:);                                                                          % Calculate filter coefficients
  
  transition = mean(filtband) * 0.2;                                                                   % Estimate filter order
  freqs = [filtband(1) - transition, filtband(1), filtband(2), filtband(2) + transition];
  fir_n = kaiserord(freqs, [0 1 0], [0.1 0.05 0.1], srate);
  
  maxn = max(maxn, fir_n);                                                                             % Make filter coefficients
  p.fir_coef{fq} = fir1(fir_n, filtband*2/srate, 'bandpass');
end

%% Run connectivity

catmatrix = [];
tr = numel(subjdat.trial);

for tt = 1:tr                                                                               % Permute subject data to match fieldtrip format
    catmatrix(:,:,tt) = subjdat.trial{tt};
end

catmatrix = permute(catmatrix,[2,3,1]);                                                     % Define some dimensions
numSamples = size(catmatrix, 1);
numTrials  = size(catmatrix, 2);
numSources = size(catmatrix, 3);

dsamples = downsample(1:numSamples,1);

parfor fq = 1:length(freqRange)
    
  ts = []; 
  H_data = complex(zeros(numSamples, numTrials, numSources));
  
  for tt = 1:numTrials
    for kk = 1:numSources
      ts = p.prefilter(catmatrix(:,tt,kk));                                                 % Mean center the timeseries before filtering
      H_data(:,tt,kk) = hilbert(p.filterfn(p.fir_coef{fq}, 1, ts));                         % Filter the data, calculate the hilbert transform, get the instantaneous phase
    end
  end

%%

nTrial = size(H_data,2);
nSource = size(H_data,3);
a = zeros(nSource,nSource,nTrial);

%% Phase-Lag Index

for trial = 1:nTrial
    adjmatTrial = zeros(nSource,nSource);
    for i = 1:nSource
        for j = 1:nSource
            phaseDiff = angle(H_data(:,trial,i)) - angle(H_data(:,trial,j));
            adjmatTrial(i,j) = abs(mean(sign(phaseDiff)));
        end
    end
    a(:,:,trial) = adjmatTrial;
end

adjmat(:,:,:,fq) = a;

%% Directed Phase-Lag Index

if directed == 1
    for trial = 1:nTrial
        adjmatTrial = zeros(nSource,nSource);
        for i = 1:nSource
            for j = 1:nSource

                phaseDiff = angle(H_data(:,trial,i)) - angle(H_data(:,trial,j));
                adjmatTrial(i,j) = mean(heavi(phaseDiff));

            end
        end
        a(:,:,trial) = adjmatTrial;
    end
end

toc
end

function adjmat = connectivity(subjdat,freqRange,srate)
%       
%   Use the phase-lag index (PLI) to analyze connectivity between EEG sensors. PLI measures the consistency of phase-lags across trials, while attenuating 
%   zero-lag synchrony (which might have occured as a result of volume conduction).
%
%   INPUT:
%
%               subjdat    =    Preprocessed single trial data in a fieldtrip structure, as obtained from ft_preprocessing (or BVAtoMatlab).
%               freqRane   =    Vector with frequency-bands to be used in analyses (i.e. [1 3; 4 7; 8 12; 13 30; 31 90]).
%               srate      =    Sampling rate in Hz.
%
%   OUTPUT:
%
%               adjmat     =    [Node X Node X Time X Frequency-band] Adjacency matrices over time for each frequency band.     
%
%   References:
%   
%   ***Note: These analyses were developed by Simeon Wong (2016).
%
%   PLI ref.: Stam CJ, Nolte G, Daffertshofer A. Phase lag index: assessment of functional connectivity from multi channel EEG and MEG with 
%       diminished bias from common sources. Hum Brain Mapp. 2007 Nov;28(11):1178-93. doi: 10.1002/hbm.20346. PMID: 17266107; PMCID: PMC6871367.
%
%%

tic
p.prefilter = @(ts) zscore(ts);
p.connfn     = @(H1,H2) abs(mean(sign(angle(H1)-angle(H2)), 2));
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
    
  p_adjmat = [];
  ts = []; 
  H_data = complex(zeros(numSamples, numTrials, numSources));
  
  for tt = 1:numTrials
    for kk = 1:numSources
      ts = p.prefilter(catmatrix(:,tt,kk));                                                 % Mean center or z-score the timeseries before filtering
      H_data(:,tt,kk) = hilbert(p.filterfn(p.fir_coef{fq}, 1, ts));                         % Filter the data, calculate the hilbert transform, get the instantaneous phase
    end
  end

  for aa = 1:numSources                                                                     % Calculate connectivity
    for bb = aa+1:numSources
      p_adjmat(aa,bb,:) = p.connfn(H_data(:,:,aa), H_data(:,:,bb));
      p_adjmat(bb,aa,:) = p_adjmat(aa,bb,:);
    end
  end

  p_adjmat = p_adjmat(:,:,dsamples);
  adjmat(:,:,:,fq) = p_adjmat;
  toc
end


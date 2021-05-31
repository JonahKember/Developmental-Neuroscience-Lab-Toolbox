%% Collect Participants to be Used in Statistics Test

fileLocation = 'C:\Data';                                                   % Specify the file location of your data.
Condition1 = 'Go';                                                          % Specify the names of each condition, as they're saved.
Condition2 = 'NoGo';

[C1,C2] = collectParticipants(fileLocation,Condition1,Condition2);

%% Run Cluster-Based Permutation Test

cfg = [];
cfg.testType = 'erp';                                                       % Type of statistict test: can be 'erp' or 'power'
cfg.avgOverTime = 'yes';                                                    % Average over a time window, either 'yes' or 'no'.
cfg.timeWindow = [.300 .500];                                               % The time window used in the test (in Seconds). 
cfg.freqWindow = [8 12];                                                    % Frequency range used in test (if cfg.dataType = 'power')
cfg.neighbours = load('Neuroscan64ChanNeighbours');                         % The neighbours used in the satistics test. Alternatively, 'Geodesic128ChanNeighbours'.

statistic = clusterStats(cfg,C1,C2);                                        % Format of test is Cond1 - Cond2.
readStat(statistic,.05);                                                    % See whether there are any effects with a p-value < .05.

%% Plot 

lay = load('Neuroscan64ChanLayout');                                        % Specify the head layout for use in plotting. Alternatively, 'Geodesic128ChanLayout'.
headplot(statistic,lay)                                                  

%% Collect Participants to be Used in Statistics Test

subjects = {'1','2','3','4'};                                               % Change this so it corresponds to each of the participant's numbers.

fileLocation = 'C:\Data';                                                   % Specify the file location of your data.
fileNameCond1 = @(id)[fileLocation,'Subj_',id,'Cond1'];                     % Rewrite 'Subj_',id,'Cond1' so it matches how the data is saved ('id' should 
fileNameCond2 = @(id)[fileLocation,'Subj_',id,'Cond2'];                     % be in place of the subject number). Do this for both conditions. 

[Cond1,Cond2] = collectParticipants(subjects,fileNameCond1,fileNameCond2); 

%% Run Cluster-Based Permutation Test

cfg = [];
cfg.testType = 'erp';                                                       % Type of statistict test: can be 'erp' or 'power'
cfg.avgOverTime = 'yes';                                                    % Average over a time window, either 'yes' or 'no'.
cfg.timeWindow = [.300 .500];                                               % The time window used in the test. 
cfg.freqWindow = [8 12];                                                    % Frequency range used in test (if cfg.dataType = 'power')
cfg.neighbours = load('Neuroscan64ChanNeighbours');                         % The neighbours used in the satistics test. Alternatively, 'Geodesic128ChanNeighbours'.

statistic = clusterStats(cfg,Cond1,Cond2);                                  % Format of test is Cond1 - Cond2.
readStat(statistic,.05);                                                    % See whether there are any effects with a p-value < .05.

%% Plot 

lay = load('Neuroscan64ChanLayout');                                        % Specify the head layout for use in plotting. Alternatively, 'Geodesic128ChanLayout'.
headplot(statistic,lay)                                                  

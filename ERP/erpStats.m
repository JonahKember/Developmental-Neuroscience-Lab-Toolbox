function stat = erpStats(Cond1,Cond2,avgOverTime,latency,neighbours)
%%
%
%   When no prior knolwedge exists as to when and where differences between conditions might exist, this function 
%   finds differences between two conditions using a cluster-based permutation test.
%
%   For more info: 
%   https://www.youtube.com/watch?v=DakPCBLY2mE&t=18s
%   https://www.fieldtriptoolbox.org/tutorial/cluster_permutation_timelock/
%
%   INPUTS
%
%       subj1           =   Array with all subjects in condition 1 (see 'collectParticipants').
%       subj2           =   Array with all subjects in condition 2 (see 'collectParticipants').
%       avgOverTime     =   Average over time window, accepts input 'yes' or 'no'.
%       latency         =   [StartTime EndTime] Time-window for statistic test, in milliseconds. 
%
%   OUTPUT
%
%       stat            =   Results of cluster-based permutation test.
%
%   *** Note: Format for test is (Condition1 - Condition2).
%%

numSubj = length(Cond1);
neighbours = neighbours.neighbours;
cfg = []; 
cfg.channel = Cond1{1, 1}.label; 
cfg.neighbours = neighbours; 
cfg.latency = latency; 
cfg.avgovertime = avgOverTime; 
cfg.avgoverchan = 'no'; 
cfg.parameter = 'avg'; 
cfg.method = 'montecarlo';
cfg.statistic = 'ft_statfun_depsamplesT';
cfg.correctm = 'cluster'; 
cfg.clusteralpha = 0.05; 
cfg.clusterstatistic ='maxsum'; 
cfg.minnbchan = 2; 
cfg.tail = 0; 
cfg.clustertail = 0; 
cfg.alpha = 0.025; 
cfg.numrandomization = 1000;    
cfg.design(1,1:2*(numSubj))  = [ones(1,(numSubj)) 2*ones(1,(numSubj))]; 
cfg.design(2,1:2*(numSubj))  = [1:(numSubj) 1:(numSubj)]; 
cfg.ivar = 1;  
cfg.uvar = 2;   

stat = ft_timelockstatistics(cfg, Cond1{:}, Cond2{:});

end
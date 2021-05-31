function stat = clusterStats(cfg,Cond1,Cond2)
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
%       Cond1           =   Array with all subjects in condition 1 (output of 'collectParticipants').
%       Cond2           =   Array with all subjects in condition 2 (output of 'collectParticipants').
%
%   OUTPUT
%
%       stat            =   Results of cluster-based permutation test.
%
%   *** Note: Format for test is (Condition1 - Condition2).
%%

nSub = length(Cond1);

if contains(cfg.testType,'erp')
    
p = []; 
p.channel = Cond1{1, 1}.label; 
p.neighbours = cfg.neighbours.neighbours;  
p.latency = cfg.latency; 
p.avgovertime = cfg.avgOverTime; 
p.avgoverchan = 'no'; 
p.parameter = 'avg'; 
p.method = 'montecarlo';
p.statistic = 'ft_statfun_depsamplesT';
p.correctm = 'cluster'; 
p.clusteralpha = 0.05; 
p.clusterstatistic ='maxsum'; 
p.minnbchan = 2; 
p.tail = 0; 
p.clustertail = 0; 
p.alpha = 0.025; 
p.numrandomization = 1000;    
p.design(1,1:2*(nSub))  = [ones(1,(nSub)) 2*ones(1,(nSub))]; 
p.design(2,1:2*(nSub))  = [1:(nSub) 1:(nSub)]; 
p.ivar = 1;  
p.uvar = 2;   

stat = ft_timelockstatistics(p, Cond1{:}, Cond2{:});

elseif contains(cfg.testType,'power')

p = [];
p.channel     = 'all'; 
p.latency   = cfg.timeWindow;
p.frequency = cfg.freqWindow;
p.avgovertime  = cfg.avgOverTime;
p.avgoverchan = 'no'; 
p.avgoverfreq = 'yes';
p.parameter   = 'powspctrm'; 
p.method      = 'montecarlo'; 
p.statistic   = 'ft_statfun_depsamplesT'; 
p.neighbours = cfg.neighbours.neighbours; 
p.correctm = 'cluster'; 
p.clusteralpha = 0.05; 
p.clusterstatistic ='maxsum'; 
p.minnbchan = 0;
p.tail = 0; 
p.clustertail = 0; 
p.alpha = 0.025; 
p.numrandomization = 1000;   

Nsub = length(Cond1); 
p.design(1,1:2*Nsub)  = [ones(1,Nsub) 2*ones(1,Nsub)]; 
p.design(2,1:2*Nsub)  = [1:Nsub 1:Nsub]; 
p.ivar             = 1; 
p.uvar             = 2; 

stat = ft_freqstatistics(p, Cond1{:}, Cond2{:});
end
end
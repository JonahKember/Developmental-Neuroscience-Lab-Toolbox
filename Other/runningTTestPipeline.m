%% Find Times where Conditions Differ Significantly
%
%   Find periods of time where two sets of data differ significantly. This function first does a running t-test to find any 
%   consecutive time-points that are significant. It then adds the t-values of these consecutive time-points to quantify the 
%   size of each effect. Then, to determine what effects are significant, it shuffles the data a large number of times, finds 
%   the largest effects, and does a hypothesis test againts this distribution of effect sizes.
%

a =  data1;                  % Condition 1 data for all subjects over time, in format [Time, Subjects]
b = data2;                   % Condition 2 data for all subjects over time, in format [Time, Subjects]
per = 1000;                  % Number of permutations used in significant testing (~.18 seconds per permutation).
p_val = .05;                 % p-value considered significant.

ttestRunning(a,b,per,p_val)

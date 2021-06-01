%% Find Times where Conditions Differ Significantly

a =  data1;                         % Condition 1 data for all subjects over time, in format [Time, Subjects]
b = data2;                          % Condition 2 data for all subjects over time, in format [Time, Subjects]
per = 1000;                         % Number of permutations used in significant testing(~.18 seconds per permutation).
p_val = .05;                        % p-value considered significant.

ttestRunning(a,b,per,p_val)
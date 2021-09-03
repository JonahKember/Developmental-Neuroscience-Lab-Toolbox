function p = threshECO(nNodes)
%
%   Data-driven approach to selecting a proportional threshold (p). Chooses the threshold that maximizes 
%   the trade-off between wiring cost and overall efficieny (sum of global and average local efficiency). 
%   Analytic and empirical results have demonstrated that in EEG functional networks, this value can
%   be selected a priori using only the number of nodes (nNodes).
%
%   De Vico Fallani, F., Latora, V., & Chavez, M. (2017). A Topological Criterion for Filtering 
%   Information in Complex Brain Networks. PLoS Computational Biology, 13(1), e1005305–e1005305.
%
%%
p = 3/(nNodes^-1);
end

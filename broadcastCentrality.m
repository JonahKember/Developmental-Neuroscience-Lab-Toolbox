function [nodeBC, globalBC] = broadcastCentrality(Network)
%%
%       Here, dynamic efficiency is measured as the mean broadcast centrality. Broadcast centrality measures the potential
%       for each node to communicate with every other node in the network (along temporal paths) over the course of the networks 
%       evolution. The alpha parameter is chosen based on the method proposed by Grindrod et al. (2011).
%
%   INPUTS:
% 
%               Network     =   [Node X Node X Time], 3-Dimensional array with static adjacency matrices over time
% 
%   OUTPUTS:
%   
%               nodeBC      =   Broadcast centrality of each node
%               globalBC    =   Broadcast centrality averaged across every node in the network
%   References:
% 
%    Grindrod, P., Parsons, M., Higham, D., & Estrada, E. (2011). Communicability across evolving networks. 
%     Physical Review. E, Statistical, Nonlinear, and Soft Matter Physics, 83(4 Pt 2), 046120–046120. 
%     https://doi.org/10.1103/PhysRevE.83.046120
% 
%    Sizemore, A., & Bassett, D. (2018). Dynamic graph metrics: Tutorial, toolbox, and tale. NeuroImage (Orlando, Fla.), 180(Pt B), 
%     417–427. https://doi.org/10.1016/j.neuroimage.2017.06.081
%
%%
time = size(Network,3);
nNodes = size(Network,1);

%% Choose an Appropriate Alpha Value (Grindrod et al., 2011)

eigenVals = zeros(nNodes,time);

for n = 1:time  
    eigenVals(:,n) = abs(eig(Network(:,:,n)));
end

maxA = 1/max(max((eigenVals)));
alpha = maxA/2;

%% Compute Local and Global Broadcast Centrality (Sizemore & Bassett,2018)

P = (eye(128) - alpha*((Network(:,:,1))))^-1;

for t = 2:time
    matRes = (eye(128) - alpha*((Network(:,:,t))))^-1;                      
    P = P*matRes;
end

Q = P/norm(P);
nodeBC = sum(Q,2);
globalBC = mean(nodeBC);
end

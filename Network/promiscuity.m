function [globalPromiscuity, localPromiscuity] = promiscuity(dynamicCommStruc)
%%  Find the Promiscuity of a Dynamic Network
%   
%   Find the local and global promiscuity of a network from its dynamic community structure. A node with low promiscuity tends to remain in the same community over time, 
%   whereas a node with high promiscuity tends to participate in a large number of the available communities. 
%
%   The local promiscuity of a node is measured as the number of communities it participates in divided by the total number of communities. 
%   Global Promiscuity is the average promiscuity of each node in the network.
%
%   INPUT 
%
%           dynamicCommStruc        =   [Node X Time] matrix with the community affiliation of each node at each time point, as retrieved from dynamicCommStruc 
%
%   OUTPUT
%
%           globalPromiscuity       =    Average promiscuity of each node in the network.
%           localPromiscuity         =   Vector with local promiscuity of each node.
%
%   References:
%   Sizemore, A., & Bassett, D. (2018). Dynamic graph metrics: Tutorial, toolbox, and tale. NeuroImage (Orlando, Fla.), 180(Pt B), 417–427.
%
%%

nNodes = size(dynamicCommStruc,1);                              % Find the number of nodes.
K = length(unique(dynamicCommStruc));                           % Find the number of communities that exist in the dynamic community structure. 
localPromiscuity = zeros(nNodes,1);                                    

for n = 1:nNodes                                                % For each node, find the number of communities it participates in then
    node = length(unique(dynamicCommStruc(n,1:end)));           % divide this by the total number of communities.
    localPromiscuity(n) = node/K;                            
end

globalPromiscuity = mean(localPromiscuity);
end

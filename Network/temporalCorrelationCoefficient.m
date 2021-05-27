function [TCC,TCCi] = temporalCorrelationCoefficient(network)
%
%   Calculate the temporal correlation coefficient (TCC) of a dynamic network. TCC measures the 
%   tendency of a node to stay connected to the same neighbours at consecutive time-points over 
%   the duration of the network.
%
%   INPUT:
%
%       network    =    [Node X Node X Time], 3-dimensional array of adjacency matrices over time
%
%   OUTPUT:
%
%       TCC        =    Average temporal correlation coefficient across all nodes
%       TCCi       =    Vector of the temporal correalation coefficient of each nodes
%%

nNodes = size(network,1);
time = size(network,3);

TCCi = zeros(nNodes,1);
TCTime = zeros(1,time);

for i = 1:nNodes
    for t = 1:(time - 1)
        num = 0;
        for j = 1:nNodes         
            if i ~= j    
            num = num + network(i,j,t)*network(i,j,t + 1);
            end
        end
        den = sqrt(sum(network(i,:,t))*sum(network(i,:,t + 1)));
            if den ~= 0 
            TCTime(t) = sum(num)/den; 
            end
    end
    TCCi(i) = (1/(time - 1))*sum(TCTime);
end
TCC = mean(TCCi);
end

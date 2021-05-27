function [globalFlex, localFlex] = flexibility(dynCS)
%%
%  The flexibility of a node is defined as the number of times it changes communities divided by the number of times it could
%  have changed communities. The global flexibility (F) of a dynamic network is the average flexibility of all nodes.
% 
%   INPUT
%         dynCS        =     [Node X Time] matrix with the community affiliation of each node at every time point (output of dynamicCommStruc)
% 
%   OUTPUT
%                 
%         globalFlex   =     Average flexibility of network
%         localFlex    =     Flexibility of each node
%
%%
nNodes = size(dynCS,1);
time = size(dynCS,2);

localFlex = zeros(nNodes,1);

for n = 1:nNodes
    flex = zeros(1,time);
       for t = 1:time - 1
             if dynCS(n,t) ~= dynCS(n,(t +1))               
             flex(t) = 1;
             end
       end
    localFlex(n) = sum(flex)/time;
end

globalFlex = mean(localFlex); 
end

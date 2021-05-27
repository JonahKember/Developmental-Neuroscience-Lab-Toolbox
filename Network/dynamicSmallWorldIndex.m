function SWI = dynamicSmallWorldIndex(Network)
%%
%   Measure the small-world index of a dynamic network. In dynamic networks, small-worldness (High SWI) exists when there is 
%   relatively high global efficiency (it takes a short amount of time for any two nodes to communicate, relative to 
%   a randomly wired network), in addition to relatively high local efficiency (a strong overlap between a nodes neighbours at sucessive 
%   timepoints, relative to a randomly wired network).
%
%   INPUT:
%
%           Network   =   [Node X Node X Time] 3-dimensional array of adjacency matrices
%           
%   OUTPUT:
%
%           SWI       =   Small-world index
%
%%

[dyn,stat] = dynamicNetwork(Network,[1,1,size(Network,3)]);                 % Retrieve both a contact sequence and an array of adjacency matrices for the network.

C = temporalCorrelation(dyn,0);                                             % Measure the temporal correaltion coefficient using the contact sequence.
[~,E] = dynamicEfficiency(stat);                                            % Measure the dynamic efficiency using the array of networks.

randDyn = randomPermutedTimes(dyn);                                         % Create a random model of a dynamic network by randomly permuting its order. 
randStat = networksFromContacts(randDyn,0);                                 % Do this for both the contact sequence and the array of networks.

Crand = temporalCorrelation(randDyn,0);                                     % Measure the correlation coefficient of the random contact sequence.
[~,Erand] = dynamicEfficiency(randStat);                                    % Measure the dynamic efficiency of the dynamic network.

SWI = (C/Crand)/(E/Erand);                                                  % Measure the small-worldness, as in Sizemore & Bassett (2018).

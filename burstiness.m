function B = burstiness(network)
%
%   The 'inter-contact-time' between two nodes is the length of time it takes for a connection to form between those two nodes.
%   A 'burst' is when two nodes show very short inter-contact times (consecutive connections in time), followed by longer and more variable inter-contact 
%   times (long periods of time without forming a connection). When the distribution of all these inter-contact-times shows a 'heavy-tail distribution', 
%   it is said to have high burstiness. Burstiness has been found in resting-state fMRI and EEG data (Thompson et al., 2017).
%
%   INPUT:
%       
%           network   =    [Node X Node X Time] 3-dimensional array of adjacency matrices over time.    
%
%   OUTPUT:
%   
%              B      =     Vector with the average burstiness coefficient of each node.
%
%   Reference:
%
%   Thompson, W., Brantefors, P., & Fransson, P. (2017). From static to temporal network theory: Applications to functional
%   brain connectivity. Network Neuroscience (Cambridge, Mass.), 1(2), 69–99. https://doi.org/10.1162/NETN_a_00011
%
%%

B = zeros(128,128);

for i = 1:size(network,1)
    for j = 1:size(network,1)
    contact = zeros(1,size(network,3));
        for t = 1:size(network,3)
            if network(i,j,t) == 1
                contact(t) = 1;
            end
        end
    ICT = diff(find(contact == 1));                                         % Find the inter-contact times (the length of time it takes for node i to connect with node j).
    B(i,j) = ((std(ICT)/mean(ICT)) - 1) / ((std(ICT)/mean(ICT)) + 1);       % Calculate the burstiness coefficient, which compares the distribution of inter-contact times 
    end                                                                     % in the network to a random (poisson) distribution.
end

B = nanmean(B);
end

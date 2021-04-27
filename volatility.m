function V = volatility(network)
%
%   Calculate the volatility of a dynamic network. Volatility, as defined by Thompson et al. (2016) measures how much, 
%   on average, connectivity between consecutive networks tends to change over the course of the network's evolution.
%
%   INPUT:
%
%           network  =     [Node X Node X Time] 3-dimensinoal array of adjacency matrices over time.    
%
%   OUTPUT:
%
%              V     =      Volatility
%
%   Reference:   
%
%   Thompson, W., Brantefors, P., & Fransson, P. (2017). From static to temporal network theory: Applications to functional
%   brain connectivity. Network Neuroscience (Cambridge, Mass.), 1(2), 69–99. https://doi.org/10.1162/NETN_a_00011
%
%%

T = size(network,3)-1;
D = zeros(1,size(network,3)-1);

for t = 1:T
    d = pdist2(network(:,:,t),network(:,:,(t + 1)),'hamming');
    D(t) = sum(d,'all');
end

V = (1/(T - 1))*sum(D);

end
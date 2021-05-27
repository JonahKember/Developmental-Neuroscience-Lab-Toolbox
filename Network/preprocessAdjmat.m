function adjmatTB = preprocessAdjmat(adjmat,thresh,weight)
%
%   After analyzing connectivity over time for each frequency band (from the function 'connectivity.m'), threshold and/or binarize each adjacency matrix. 
%
%   INPUT: 
%
%           adjmat      =    [Node, Node, Time, Frequency-band], as calculated in the function 'connectivity'.
%           thresh      =    Proportion of strongest weights to be maintained (between 0 and 1).
%           weight      =    0 if binarized, 1 if weighted.  
%           
%   OUTPUT:
%
%           adjmatTB    =    [Node, Node, Time, Frequency-band], with all adjacency matrices thresholded and weighted appropriately.
%
%%

if weight == 0
    fprintf('Strongest %0.0f%% of weights maintained, binarized. \n',thresh*100);
elseif weight == 1
    fprintf('Strongest %0.0f%% of weights maintained, weighted. \n',thresh*100); 
end

adjmatTB = zeros(size(adjmat));

for fq = 1:size(adjmat,4)
    for t = 1:size(adjmat,3)
        net = adjmat(:,:,t,fq); 
        netT = threshold_proportional(net, thresh);
        if weight == 0
            adjmatTB(:,:,t,fq) = double(netT > 0);
        elseif weight == 1
            adjmatTB(:,:,t,fq) = netT; 
        end
    end
end
end
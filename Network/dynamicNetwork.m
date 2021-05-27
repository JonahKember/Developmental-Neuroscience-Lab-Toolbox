function [dyn,net,Info] = dynamicNetwork(network,time)
%% 
%   Return a contact sequence from static adjacency matrices over time. Averages the static networks within the specified 
%   time interval while maintaining the proportional degree threshold of the original network.
%
%   INPUTS:
%
%        network     =    [Node X Node X Time] 3-dimensional array with static adjacency matrices over time
%        time        =    [Start Time, Interval, End Time] 
%  
%   OUPUT:
%       
%        dyn         =    Contact sequence 
%        net         =    [Node X Node X Time] 3-dimensional array of static
%                         adjacency matrices, averaged across each specified interval
%
%   Requires Brain Connectivity toolbox and Dynamic Graph Metrics toolbox
%
%%
startTime = time(1);
interval = time(2);
endTime = time(3);

if mod(((endTime - startTime)/interval),1) ~= 0
    fprintf('Error: Total time is not divisible by interval\r\n')
    return
else

net = [];
nNodes = size(network,1);

    for n = startTime:interval:(endTime - interval)

        netInt = network(:,:,n:(n + (interval - 1)));
        thresh = nnz(netInt(:,:,1))/(nNodes^2 - nNodes);
        netInt = mean(netInt,3);
        netInt = threshold_proportional(netInt,thresh);
        netInt = weight_conversion(netInt,'binarize');
        net = cat(3, net, netInt);

    end

dyn = arrayToContactSeq(net,0);

Info.Nodes = size(net,1);
Info.Length = size(net,3);
Info.Thresh = thresh;
Info.StartTime = startTime;
Info.EndTime = endTime; 
Info.Interval = interval;

end
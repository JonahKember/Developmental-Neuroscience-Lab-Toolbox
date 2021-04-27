function  dynamicPlot(network,time)
%%
%   Plot adjacency matrices over time.
%
%%
%   INPUTS:
%            Network           =   3-D array of adjacency matrices over time
%            Time (optional)   =   Time vector of size(Network,3)
%
%%
if exist('time','var')
    else
    time = 1:size(network,3);
end

for n = 1:length(time)
    imagesc(network(:,:,n));
    xlabel(time(n))
    set(gcf,'color','w');
    pause(.2)
end

end

function staticCS = staticCommStruc(Network)
%%  
%  Detect the community structure over time of static networks over time.
%
%  Note: Static community structures over time should NOT be used in any analyses that require a dynamic community structure (i.e., flexibility, promiscuity).
%  Since the communities that exist betwen time points have not yet been related to one another, those measures are meaningless. In order to use those analyses,
%  static community structures shuold be run through the script 'dynamicCommStruc', which meaningfully relates communities at time (t) with time (t + 1).
%
%  Note: Due to the algorithm used to detect community structure, there may be some very minor random variation from one run to another (https://en.wikipedia.org/wiki/Louvain_method).
%       
%   INPUT
% 
%           Network     =   [Node X Node X Time] 3 dimensional array of adjacency matrices over time.
%      
%   OUTPUT
%
%           staticCS    =   [Node X Time] Static community affiliation vector over time.
%
%
%   References:
%   
%   Rubinov, M., & Sporns, O. (2010). Complex network measures of brain connectivity: Uses and 
%   interpretations. NeuroImage (Orlando, Fla.), 52(3), 1059–1069. 
%
%   ***Requires the Brain Connectivity Toolbox
%%

staticCS = zeros(size(Network,1),size(Network,3));

for n = 1:size(Network,3)                                               
    [CS] = community_louvain(Network(:,:,n),1);
    staticCS(:,n) = CS; 
end

end


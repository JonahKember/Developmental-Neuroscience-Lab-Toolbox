function dynamicCommStruc = dynamicCommStruc(staticCS, minJac)
%% Detect Dynamic Community Structure 
%   
%   After detecting the community structure for static adjacency matrices over time, assess the similarity between time-neighbouring communities at time (t) and time (t+1) 
%   using the function 'communitySimilarity' (which measures similarity using the Jaccard Indexa). For each community in the (t + 1) vector, redefine it as the community 
%   in vector (t) with the highest similarity, so long as its similarity is greater than the parameter 'minJac'. 
%   
%  INPUT:
%               
%            staticCommStruc      =    [Node X Time] matrix with the community affiliation of each node for every time point (detected from static adjacency matrices).
%            minJaccard            =   Minimum similarity required to be considered the same community (0 to 1).    
%               
%  OUTPUT:           
%
%            dynamicCommStruc    =    [Node X Time] matrix with the community affiliation of each node for every time point. 
%                                     Communities at (t) correspond to the communities with which they were most similar to at (t - 1).
%
%Reference:
% 
% Cherifi, H., Szymanski, B.K. et al. On community structure in complex networks: challenges and opportunities.
%       Appl Netw Sci 4, 117 (2019). https://doi.org/10.1007/s41109-019-0238-9
%
%% 
 
time = size(staticCS,2);                                            % Assign each community a unique value. This is necessary for certain 
for n = 1:time                                                      % measures (i.e., Promiscuity) to be meaningful.                                                              
    staticCS(:,n) = staticCS(:,n) + rand(1);
end
%%

for timeOne = 1:size(staticCS,2)-1
    
timeTwo = timeOne + 1;

A = staticCS(:,timeOne);                                            % Create an adjacency matrix 'A_mat' that includes all the communities at time (t),
B = staticCS(:,timeTwo);                                            % and an adjacency matrix 'B_mat'  with all the communities at time (t + 1).
A_mat = zeros(length(A));
B_mat = zeros(length(B));

for n = 1:length(A)
    for nn = 1:length(A)                             
         if A(n) == A(nn)
            A_mat(n,nn) = A(n);
         end
         if B(n) == B(nn)
            B_mat(n,nn) = B(n);
         end
    end
end

SimilarityMat = communitySimilarity(A_mat,B_mat);                   % Assess the similarity of each community in 'A_mat' with each community in 'B-mat' 
[simOfNeighbour,locationSimNeighbour] = max(SimilarityMat);         % using the function 'communitySimilarity'.
        
numa = unique(staticCS(:,timeOne));
numb = unique(staticCS(:,timeTwo));
Change = staticCS(:,timeTwo);
        
        
for nn = 1:length(simOfNeighbour)                                   % Assign each community at time (t + 1) as the community with which it is most similar
    if simOfNeighbour(nn) > minJac                                  % at time (t), so long as the similarity is greater than the parameter 'minJac'.
               Old = numb(nn);
               New = numa(locationSimNeighbour(nn));          
               Change(Change == Old) = New;
    end
end

staticCS(:,timeTwo) = Change;
dynamicCommStruc = staticCS;

end


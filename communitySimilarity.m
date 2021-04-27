function SimilarityMatrix = communitySimilarity(A_mat,B_mat)
%%
%   Assess the similarity between the communities in two matrices. To assess similarity, take the Jaccard index between the subdiagonal in matrix A and the 
%   corresponding subdiagonal in matrix B. Do this for each subdiagonal, and take the average value as a measure of similarity. The Jaccard index is defined 
%   as the size of the intercection of the set divided by the size of the union of the set. 
%
%       INPUT: 
%
%               A_mat               =   [Node X Node] adjacency matrix where each unique value corresponds to a unique community.
%               B_mat               =   [Node X Node] adjacency matrix where each unique value corresponds to a unique community.
%       
%       OUTPUT:
%       
%               SimilarityMatrix    =   Matrix showing the similarity between each community in A_mat (rows) and each community in B_mat (columns). 
%%

a = unique(A_mat);
allCommA = a(a~=0);
b = unique(B_mat);
allCommB = b(b~=0);

SimilarityAB = zeros(1,length(allCommB));
SimilarityMatrix = zeros(length(allCommA),length(allCommB));

for A = 1:length(allCommA)
    communityA = allCommA(A);
    
    for B = 1:length(allCommB)
         communityB = allCommB(B);
         jaccard = zeros(1,length(A_mat) - 1);
         
       for subDiagonal = 1:length(A_mat) - 1
          a = find(diag(A_mat,subDiagonal) == communityA);
          b = find(diag(B_mat,subDiagonal) == communityB);
          jaccard(subDiagonal) = length(intersect(a,b))/length(union(a,b)); 
       end
         
         JacIndex = nanmean(jaccard,'all'); 
         SimilarityAB(B) = JacIndex;
     end
         
         SimilarityMatrix(A,:) = SimilarityAB;
         SimilarityMatrix(isnan(SimilarityMatrix)) = 0;
end

function [A,D] = getMatrixMeanValueWeights(V,F,b_i)
%   Legnenerálja A szomszédsági-, és D fokszámmátrixokat az F lapok és b_i
%   határindexek segítségével
%   A : szomszédsági mátrix Floater-féle mean-value csúcsokkal
%   D : fokszámmátrix
%   V : vertexek
%   F : lapok
%   N : mátrixok mérete, Vertexek száma
%   b_i: boundary_indices, a határpontok indexei
N = length(V);
A = zeros(N);
D = zeros(N);
for i = 1:N
   for j = 1:N
      if i ~= j
         F1 = F(sum(F == i,2) > 0,:);
         if min(size(F1(sum(F1 == j,2) > 0,:))) == 2
             triangles = F1(sum(F1 == j,2) > 0,:);
             % The Y vector (edge) is common
             Y = V(j,:) - V(i,:);
             Y = Y/norm(Y);
             % angle 1
             tr_1 = setdiff(triangles(1,:),[i,j]);
             X = V(tr_1,:) - V(i,:);
             X = X/norm(X);
             angle_1 = acos(dot(X,Y));
             % angle 2
             tr_2 = setdiff(triangles(2,:),[i,j]);
             X = V(tr_2,:) - V(i,:);
             X = X/norm(X);
             angle_2 = acos(dot(X,Y));
             A(i,j) = (tan(angle_1/2) + tan(angle_2/2))/norm(V(i,:) - V(j,:));
         end
      end
   end
end

for i = 1:N
    di = getNumberOfNeighbors(i,F);
    if any(b_i==1)
        di = di + 1;
    end
    D(i,i) = di;
end
end


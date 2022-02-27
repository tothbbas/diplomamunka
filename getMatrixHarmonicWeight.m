function [A,D] = getMatrixHarmonicWeight(V,F,b_i)
%   Legnenerálja A szomszédsági-, és D fokszámmátrixokat az F lapok és B (méret alapján)
%   A : szomszédsági mátrix harmonikus, vagy kotangens súlyokkal
%   D : fokszámmátrix
%   V : vertexek
%   F : lapok
%   N : mátrixok mérete, Vertexek száma
%   b_i: boundary_indices, a határpontok indexei
N = length(V);
A = zeros(N);
D = zeros(N);
for i = 1:N
   for j = i:N
      if i ~= j
         F1 = F(sum(F == i,2) > 0,:);
         if min(size(F1(sum(F1 == j,2) > 0,:))) == 2
             triangles = F1(sum(F1 == j,2) > 0,:);
             % angle 1
             tr_1 = setdiff(triangles(1,:),[i,j]);
             X = V(i,:) - V(tr_1,:);
             X = X/norm(X);
             Y = V(j,:) - V(tr_1,:);
             Y = Y/norm(Y);
             angle_1 = acos(dot(X,Y));
             % angle 2
             tr_2 = setdiff(triangles(2,:),[i,j]);
             X = V(i,:) - V(tr_2,:);
             X = X/norm(X);
             Y = V(j,:) - V(tr_2,:);
             Y = Y/norm(Y);
             angle_2 = acos(dot(X,Y));
             % weight
             w = (cot(angle_1) + cot(angle_2))/2;
             A(i,j) = w;
             A(j,i) = w;
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


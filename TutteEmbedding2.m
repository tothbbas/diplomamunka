function [outV, outF] = TutteEmbedding2(inV,inF,findmostusedvertice,debug)
% Tutte-féle beágyazás elkészítése
%   inV : bemeneti csúcsok 
%   inF : bemeneti lapok
if nargin > 3
    debug = 1;
    delete_index = findMostUsedVertex(inF);
elseif nargin > 2
    delete_index = findMostUsedVertex(inF);
    debug = 0;
else
    delete_index = 1;
    debug = 0;
end

% get boundary indices, neighbors of the deleted vertex (in correct order);
boundary_indices = getVertexNeighborsInOrder(delete_index,inF);
boundary_indices(boundary_indices == length(inV)) = delete_index; % a törlés után változik az indexelés
[V,F,~] = deleteVertexAndCorrespondingFaces(inV,inF,delete_index);
N = length(V);
n = length(boundary_indices);   % boundary points
k = N - n;  % inner points
for i = 1:n
   % swap boundary vertexes to the end of the V vertex array
   old = boundary_indices(i);
   new = k+i;
   if any(boundary_indices==new)
      idx = boundary_indices==new;
      boundary_indices(idx) = old;
   end
   V([old,new],:) = V([new,old],:);
   boundary_indices(i) = new;
   F(F == old) = -1;
   F(F == new) = old;
   F(F == -1) = new;
end

A = zeros(N+1);
D = zeros(N+1);

for i = 1:N
    neighbors = getVertexNeighbors(i,F);
    A(i,neighbors) = 1;
    di = getNumberOfNeighbors(i,F);
    if any(boundary_indices==1)
        di = di + 1;
    end
    D(i,i) = di;
end

D = D(1:N,1:N);
A = A(1:N,1:N);
boundary_points = [cos((2*(1:n)*pi)/n);sin(2*(1:n)*pi/n)]';

A1 = A(1:k,1:k);    % inner points
D1 = D(1:k,1:k);    % inner points
B = A(1:k,k+1:N);
C = boundary_points;

Y = D1 - A1;
Z = B*C;
X = Y\Z;

outV = [X;boundary_points];
outF = F;
end


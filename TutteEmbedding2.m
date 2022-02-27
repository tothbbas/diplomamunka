function [outV, outF] = TutteEmbedding2(inV,inF,weights,findmostusedvertice)
% Tutte-féle beágyazás elkészítése
%   inV : bemeneti csúcsok 
%   inF : bemeneti lapok
%   weights : az A szomszédsági mátrix súlyait adjuk meg:
%       - u : uniform (default : ettől különböző karakter is ezt eredményezi)
%       - h : harmonic / cotangent
%       - m : mean-value (Floater)
if nargin > 3
    delete_index = findMostUsedVertex(inF);
else
    delete_index = 1;
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

if ismember(weights,'h')
    [A,D] = getMatrixHarmonicWeights(V,F,boundary_indices);
elseif ismember(weights,'m')
    [A,D] = getMatrixMeanValueWeights(V,F,boundary_indices);
else
    [A,D] = getMatrixUniformWeight(F,N,boundary_indices);
end

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


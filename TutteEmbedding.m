function [outV, outF] = TutteEmbedding(inV,inF,findmostusedvertice,debug)
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
boundary_indices = getVertexNeighbors(delete_index,inF);
boundary_indices(boundary_indices == length(inV)) = delete_index; % a törlés után változik az indexelés
[V,F,~] = deleteVertexAndCorrespondingFaces(inV,inF,delete_index);
N = length(V);
n = length(boundary_indices);   % boundary points
k = N - n;  % inner points
disp(boundary_indices)
disp(V)
for i = 1:n
   % ITT A HIBA
   % swap boundary vertexes to the end of the V vertex array
   
   
   
   old = boundary_indices(i);
   new = k+i;
   V([old,new],:) = V([new,old],:);
   if any(boundary_indices==new)
      idx = find(boundary_indices==new);
      boundary_indices(idx) = old;
   end
   boundary_indices(i) = new;
   boundary_indices()
   F(F == old) = -1;
   F(F == new) = old;
   F(F == -1) = new;
   disp(boundary_indices')
end

outV = V;
outF = F;

end
function [outV,outE] = TutteEmbedding(inV,inF,findmostusedvertice)
% Tutte-féle beágyazás elkészítése
%   inV : bemeneti csúcsok 
%   inF : bemeneti lapok
if nargin > 2
    delete_index = findMostUsedVertex(inF);
else
    delete_index = 1;
end
[V,F,B] = deleteVertexAndCorrespondingFaces(inV,inF,delete_index);
k = length(B);
boundary_points = [cos((2*(1:k)*pi)/k);sin(2*(1:k)*pi/k)];
end


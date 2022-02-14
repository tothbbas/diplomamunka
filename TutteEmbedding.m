function [outV,outE] = TutteEmbedding(inV,inF,findmostusedvertice)
% Tutte-féle beágyazás elkészítése
%   inV : bemeneti csúcsok 
%   inF : bemeneti lapok
if nargin > 2
    delete_index = findMostUsedVertex(inF);
else
    delete_index = 1;
end

boundary_indexes = getVertexNeighbors(delete_index,inF);
boundary_indexes(boundary_indexes == length(inV)) = delete_index; % a törlés után változik az indexelés
[V,F,B] = deleteVertexAndCorrespondingFaces(inV,inF,delete_index);
k = length(B);

boundary_points = [cos((2*(1:k)*pi)/k);sin(2*(1:k)*pi/k)];
xCoords = boundary_points(1,:);
yCoords = boundary_points(2,:);
A = zeros(length(V));
resX = zeros(length(V),1);
resY = zeros(length(V),1);

for i = 1:length(V)
    if sum(i == boundary_indexes)
        A(i,i) = 1;
        resX(i) = xCoords(boundary_indexes==i);
        resY(i) = yCoords(boundary_indexes==i);
    else
        neighbors = getVertexNeighbors(i,F);
        di = length(neighbors);
        A(i,neighbors) = 1/di;
    end
end

A = A - eye(length(A));
A(all(~A,2),:) = []; % delete all zero rows

b = zeros(1,length(V) - length(boundary_indexes))';

x = linsolve(A,b);
disp(A)
disp(b)
disp(x)
end


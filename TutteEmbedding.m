function [outV, outF] = TutteEmbedding(inV,inF,findmostusedvertice,debug)
% Tutte-féle beágyazás elkészítése
%   inV : bemeneti csúcsok 
%   inF : bemeneti lapok
if nargin > 3
    debug = 1;
elseif nargin > 2
    delete_index = findMostUsedVertex(inF);
    debug = 0;
else
    delete_index = 1;
    debug = 0;
end

boundary_indices = getVertexNeighbors(delete_index,inF);
boundary_indices(boundary_indices == length(inV)) = delete_index; % a törlés után változik az indexelés
[V,F,B] = deleteVertexAndCorrespondingFaces(inV,inF,delete_index);
k = length(B);
boundary_points = [cos((2*(1:k)*pi)/k);sin(2*(1:k)*pi/k)]';

if debug
    disp(boundary_indices)
    disp(boundary_points)
    pause()
end

A = zeros(length(V));
% b = zeros(length(boundary_points),2);
% b(boundary_indices,:) = boundary_points;

for i = 1:length(V)
    if sum(i == boundary_indices)
        A(i,i) = 1;
    else
        neighbors = getVertexNeighbors(i,F);
        di = getNumberOfNeighbors(i,F); % szerintem nem lesz baj a fokszámmal, mert csak belső csúcsokra kérjük le!
        A(i,neighbors) = 1/di;
    end
end
unknown_indices = setdiff((1:length(V)),boundary_indices);
if debug
    disp(A)
    pause()
end
A(boundary_indices,:) = [];
if debug
    disp(A)
    pause()
end
A(:,unknown_indices) = [];
if debug
    disp(A)
    pause()
end
x = A/boundary_points';
if debug
    disp(x)
    pause()
end
outV = zeros(length(V),2);
if debug
    disp(outV)
    pause()
end
outV(boundary_indices,:) = boundary_points;
if debug
    disp(outV)
    pause()
end
outV(unknown_indices,:) = x;
if debug
    disp(outV)
    pause()
end
outF = F;

end


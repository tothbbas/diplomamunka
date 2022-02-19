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

boundary_indices = getVertexNeighbors(delete_index,inF);
boundary_indices(boundary_indices == length(inV)) = delete_index; % a törlés után változik az indexelés
[V,F,B] = deleteVertexAndCorrespondingFaces(inV,inF,delete_index);
unknown_indices = setdiff((1:length(V)),boundary_indices)';
k = length(B);
boundary_points = [cos((2*(1:k)*pi)/k);sin(2*(1:k)*pi/k)]';

% Ordering


if debug
    disp(unknown_indices)
    disp(boundary_indices)
    disp(boundary_points)
    pause()
end

A = zeros(length(V)+1);
D = zeros(length(V)+1);

for i = 1:length(V)
    neighbors = getVertexNeighbors(i,inF);
    A(i,neighbors) = 1;
    di = getNumberOfNeighbors(i,inF); % szerintem nem lesz baj a fokszámmal, mert csak belső csúcsokra kérjük le!
    D(i,i) = di;
end

D = D(1:length(V),1:length(V));
A = A(1:length(V),1:length(V));

A1 = A;
A1(boundary_indices,:) = [];
A1(:,boundary_indices) = [];
D1 = D;
D1(boundary_indices,:) = [];
D1(:,boundary_indices) = [];

B = A;
B(:,unknown_indices) = [];
B(boundary_indices,:) = [];

C = boundary_points;

Y = D1 - A1;
Z = B*C;
X = Y/Z;

outV = zeros(length(V),2);
outV(boundary_indices,:) = boundary_points;
outV(unknown_indices,:) = X;
outF = F;
end


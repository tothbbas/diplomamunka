function [outV,outF] = embedCuttedMesh(V,F,n,weights)
%   Vágott meshek síkbaágyazása
%   V : bemeneti vertexek (rendezett)
%   F : bemeneti lapok
%   n : "boundary" vagy határvertexek száma
%   weights : súlyozás, h : Harmonic, m : mean-value, other : uniform

N = length(V);
k = N - n;  % inner points
boundary_indices = N-n:N;

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


function [A,D] = getMatrixUniformWeight(F,N,b_i)
%   Legnenerálja A szomszédsági-, és D fokszámmátrixokat az F lapok és B (méret alapján)
%   A : szomszédsági mátrix (súlymátrix, 1 súlyokkal)
%   D : fokszámmátrix
%   F : lapok
%   N : mátrixok mérete, Vertexek száma
%   b_i: boundary_indices, a határpontok indexei
A = zeros(N);
D = zeros(N);
for i = 1:N
    neighbors = getVertexNeighbors(i,F);
    A(i,neighbors) = 1;
    di = getNumberOfNeighbors(i,F);
    if any(b_i==1)
        di = di + 1;
    end
    D(i,i) = di;
end

end


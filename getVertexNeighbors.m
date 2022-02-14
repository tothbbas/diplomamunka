function neighbors = getVertexNeighbors(vertex_idx,F)
% Megadja egy adott vertex_idx -ű vertex F lapok által meghatározott szomszédjait
%   F : lapok (faces)
%   vertex_idx : adott indexű vertex

u = unique(F(sum(A == vertex_idx, 2) > 0, :));
neighbors = u(u~=vertex_idx);
end


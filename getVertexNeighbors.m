function neighbors = getVertexNeighbors(vertex_idx,F)
% Megadja egy adott "vertex_idx"-ű index F által meghatározott
% szomszédjait.
%   vertex_idx : vertex index
%   F : lapok
u = unique(F(sum(F == vertex_idx, 2) > 0, :));
neighbors = u(u~=vertex_idx);
end


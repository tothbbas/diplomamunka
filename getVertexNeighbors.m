function neighbors = getVertexNeighbors(vertex_idx,F)
% Megadja egy adott vertex_idx -ű vertex F lapok által meghatározott szomszédjait
%   F : lapok (faces)
%   vertex_idx : adott indexű vertex

% megnézzük, F melyik sorában van benne a vertex_idx -ű vertex, (ahol a sum
% nagyobb, mint 0), majd vesszük ezeket a sorokat és unique vektort
% készítünk az elemeiből. illetve eltávolítjuk belőle a vertex_idx -ű
% elemet
u = unique(F(sum(F == vertex_idx, 2) > 0, :));
neighbors = u(u~=vertex_idx);
end


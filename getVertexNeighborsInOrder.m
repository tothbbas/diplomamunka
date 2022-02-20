function neighbors = getVertexNeighborsInOrder(vertex_idx,F)
% Megadja egy adott vertex_idx -ű vertex F lapok által meghatározott
% szomszédjait helyes körbejárási sorrendben
%   F : lapok (faces)
%   vertex_idx : adott indexű vertex

u = unique(F(sum(F == vertex_idx, 2) > 0, :));
edges_num = length(u(u~=vertex_idx));
neighbor_edges = zeros(edges_num,2);
counter = 1;

for i = 1:length(F)
    v = F(i,:);
    if sum(v(vertex_idx == v)) > 0
        neighbor_edges(counter,:) = v(v ~= vertex_idx);
        counter = counter + 1;
    end
end

neighbors = zeros(length(neighbor_edges),1);
neighbors(1) = neighbor_edges(1,1);
row = 1;
other = 2;
counter = 2;
while min(size(neighbor_edges)) == 2
    element = neighbor_edges(row,other);
    neighbors(counter) = element;
    neighbor_edges(row,:) = [];
    [row,col] = find(neighbor_edges == element,1,'first');
    if col == 1
        other = 2;
    else
        other = 1;
    end
    counter = counter + 1;
end


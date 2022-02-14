function idx = findMostUsedVertex(F,n)
% A legtöbbet használt vertex megkeresése
%   F : lapok mátrixa, n * 3
if nargin > 2
    number_of_vertices = n;
else
    number_of_vertices = max(max(F));
end

% leszámoljuk, melyik vertexet hányszor használtuk, majd kiválasztjuk a
% leggyakoribban használtat
vertex_uses = zeros(1,number_of_vertices);
for i = 1:number_of_vertices
    idx = (F == i);
    vertex_uses(i) = sum(idx(:));
end

[~,idx] = max(vertex_uses);

end


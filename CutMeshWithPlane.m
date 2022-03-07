function [Vout,Fout,B] = CutMeshWithPlane(V,F,p,n,K)
% Mesh vágása síkkal
%   V : bemeneti vertexek listája
%   F : bemeneti lapok listája
%   p,n : a síkot meghatározó pont, illetve normálvektor
%   Vout : Cell array, amiben a megfelelő vertexek szerepelnek
%   Fout : Cell array, amiben a megfelelő lapok szerepelnek
%   B : Határvertexek száma
%   K : megnézzük, hogy a sík milyen közel található a vertexekhez. Ha
%   valamelyikhez túl közel, akkor eltoljuk a normálvektora irányába. Az
%   eps adja meg azt a távolságot, amire már nem kell eltolnunk a síkot

% Check if the plane crosses a vertex
distances = (V - p)*n;
if min(abs(distances)) < K
%     move plane
end
% assume that no point is on the plane
vertices_under_plane = find(distances < 0);
vertices_over_plane = find(distances > 0);
triangles_under_plane = [];
triangles_over_plane = [];
triangles_cut_by_plane = [];
for i = 1:length(F)
    triangle = F(i,:);
    common = intersect(triangle,vertices_under_plane);
    if isempty(common)
        triangles_over_plane = [triangles_over_plane;triangle];
    elseif length(common) < 3
        triangles_cut_by_plane = [triangles_cut_by_plane;triangle];
    else
        triangles_under_plane = [triangles_under_plane;triangle];
    end
end

triangles_under_plane = [triangles_under_plane;triangles_cut_by_plane];
boundary_vertices_unordered = intersect(unique(reshape(triangles_under_plane,1,[])),vertices_over_plane);

% order boundary vertices
boundary_vertices_ordered = zeros(length(boundary_vertices_unordered),1);
current_vertex = boundary_vertices_unordered(1);
for i = 1:length(boundary_vertices_ordered)
    boundary_vertices_ordered(i) = current_vertex;
    neighbors = intersect(setdiff(triangles_cut_by_plane(any(triangles_cut_by_plane == current_vertex,2),:),current_vertex),vertices_over_plane);
    if ~ismember(neighbors(1),boundary_vertices_ordered)
        current_vertex = neighbors(1);
    else
        current_vertex = neighbors(2);
    end
end

Vout = cell(2,1);
Fout = cell(2,1);

% OVER
boundary_vertices_over = boundary_vertices_ordered;
non_boundary_over = setdiff(vertices_over_plane,boundary_vertices_over);
vertices_over = zeros(length(non_boundary_over)+length(boundary_vertices_over),3);
for i = 1:length(non_boundary_over)
    % first inner vertices
    vertices_over(i,:) = V(non_boundary_over(i),:);
    % itt egy trükköt alkalmazunk. -i -re változtatjuk az értékeket a
    % megfelelő helyeken. ekkor a két ciklusunk végére egy csak negatív
    % értékekből álló mátrixot kapunk a megfelelő indexekkel, melyet elég
    % csak -1 -gyel megszoroznunk és megkapjuk a megfelelő lapoknak a
    % mátrixát.
    triangles_over_plane(triangles_over_plane == non_boundary_over(i)) = -i;
end

for i = length(non_boundary_over)+1:length(vertices_over)
    vertices_over(i,:) = V(boundary_vertices_over(i - length(non_boundary_over)),:);
    triangles_over_plane(triangles_over_plane == boundary_vertices_over(i - length(non_boundary_over))) = -i;
end

triangles_over_plane = triangles_over_plane * -1;
Vout{1} = vertices_over;
Fout{1} = triangles_over_plane;

% UNDER
non_boundary_under = setdiff(vertices_under_plane,boundary_vertices_ordered);
disp(non_boundary_under)
vertices_under = zeros(length(non_boundary_under)+length(boundary_vertices_ordered),3);
for i = 1:length(non_boundary_under)
    % first inner vertices
    vertices_under(i,:) = V(non_boundary_under(i),:);
    triangles_under_plane(triangles_under_plane == non_boundary_under(i)) = -i;
end

for i = length(non_boundary_under)+1:length(vertices_under)
    vertices_under(i,:) = V(boundary_vertices_ordered(i - length(non_boundary_under)),:);
    triangles_under_plane(triangles_under_plane == boundary_vertices_ordered(i - length(non_boundary_under))) = -i;
end

triangles_under_plane = triangles_under_plane * -1;
Vout{2} = vertices_under;
Fout{2} = triangles_under_plane;
B = length(boundary_vertices_ordered);

end

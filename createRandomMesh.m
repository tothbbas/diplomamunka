function [V,F] = createRandomMesh(n)
% Veletlenszeru, n csucsbol allo mesh letrehozasa

t = 2*pi*rand(n,1);
r = sqrt(rand(n,1));
x = r.*cos(t);
y = r.*sin(t);

points = [x,y];
DT = delaunayTriangulation(points);
V = DT.Points;
F = DT.ConnectivityList;

end


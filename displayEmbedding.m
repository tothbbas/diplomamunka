function displayEmbedding(V,F,color)
% beagyazas megjelenítése a vertexek, illetve a lapok alapján
%   V : vertexek
%   F : lapok
%   color : szín (opcionális)
if nargin > 2
    c = color;
else
    c = [0.5765, 0.7412, 0.5490];
end
X = V(:,1);
Y = V(:,2);
Z = zeros(length(V),1);
trisurf(F,X,Y,Z,'FaceColor',c);
lighting phong;
camproj('perspective');
axis square; 
axis off;
axis equal
axis tight;
end


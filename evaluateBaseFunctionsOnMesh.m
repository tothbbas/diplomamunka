function Out = evaluateBaseFunctionsOnMesh(V,E,Ve)
tic
%   Bázisfüggvények kiértékelése az adott mátrixokon
%   V : merge-elt háromszögháló
%   E : ismert függvényértékek
%   Ve : n x 2 mátrix a pontok koordinátáival, ahol a függvényértékek ki
%   vannak értékelve
Out = zeros(size(V,1),length(E));
for i=1:length(E)    
    f = scatteredInterpolant(Ve(:,1),Ve(:,2),E(i,:)','linear','none');
    Out(:,i) = f(V(:,1),V(:,2));
end
toc
end


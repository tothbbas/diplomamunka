function approx2(Vm,Va,V,Vold,Fm,Fa,Ea,E)
% Legjobb kozelites eloallitasa
%   Vm : mergelt alappontrendszer
%   Va : kis elemszamu, approximalo alappontrendszer
%   V : meshunk beagyazasa
%   Vold : eredeti mesh 3D pontjai
%   Fm : mergelt alappontrendszerhez tartozó lapok
%   Fa : megjelenítéshez használt, 2D háromszögelése az approximációnak
%   Ea : ortonormalt rendszer, az approximalo alappontrendszerrel
%   E : ortonormalt rendszer, az eredeti meshunk szerint

Out_a = evaluateBaseFunctionsOnMesh(Vm,Ea,Va);  % random pontrendszer bázisfüggvényei, kiértékelve a merge-elt alappontrendszeren
Out = evaluateBaseFunctionsOnMesh(Vm,E,V);  % eredeti beágyazás bázisfüggvényei kiértékelve a merge-elt alappontrendszeren
n = size(Out_a,2);
c = zeros(3,n);
F_1 = scatteredInterpolant(V(:,1),V(:,2),Vold(:,1),'linear'); % R^{2}-->R^{3} függvény 1. koordinátái
F_2 = scatteredInterpolant(V(:,1),V(:,2),Vold(:,2),'linear'); % R^{2}-->R^{3} függvény 2. koordinátái
F_3 = scatteredInterpolant(V(:,1),V(:,2),Vold(:,3),'linear'); % R^{2}-->R^{3} függvény 3. koordinátái
Y = zeros(size(Out_a,1),3);
Y(:,1) = F_1(Vm(:,1),Vm(:,2));  % R^{2}-->R^{3} függvény 1. koordinátái a merge-elt alappontrendszeren
Y(:,2) = F_2(Vm(:,1),Vm(:,2));  % R^{2}-->R^{3} függvény 2. koordinátái a merge-elt alappontrendszeren
Y(:,3) = F_3(Vm(:,1),Vm(:,2));  % R^{2}-->R^{3} függvény 3. koordinátái a merge-elt alappontrendszeren

for i=1:n
    % együtthatók kiszámítása
    c(1,i) = CalculateDot21(Vm,Fm,Out_a(:,i),Y(:,1));
    c(2,i) = CalculateDot21(Vm,Fm,Out_a(:,i),Y(:,2));
    c(3,i) = CalculateDot21(Vm,Fm,Out_a(:,i),Y(:,3));
end

y = (c*Ea)';
disp(size(y))
displayObj(y,Fa)
end


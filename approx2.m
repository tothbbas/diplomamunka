function approx2(Vm,Va,V,Vold,Fm,Fa,Ea,E)
% Legjobb kozelites eloallitasa
%   Vm : mergelt alappontrendszer
%   Fm : mergelt alappontrendszerhez tartozó lapok
%   Va : kis elemszamu, approximalo alappontrendszer
%   V : meshunk beagyazasa
%   Ea : ortonormalt rendszer, az approximalo alappontrendszerrel
%   E : ortonormalt rendszer, az eredeti meshunk szerint

Out_a = evaluateBaseFunctionsOnMesh(Vm,Ea,Va);
Out = evaluateBaseFunctionsOnMesh(Vm,E,V);
n = size(Out_a,2);
c = zeros(3,n);
F_1 = scatteredInterpolant(V(:,1),V(:,2),Vold(:,1),'linear');
F_2 = scatteredInterpolant(V(:,1),V(:,2),Vold(:,2),'linear');
F_3 = scatteredInterpolant(V(:,1),V(:,2),Vold(:,3),'linear');
Y = zeros(size(Out_a,1),3);
Y(:,1) = F_1(Vm(:,1),Vm(:,2));
Y(:,2) = F_2(Vm(:,1),Vm(:,2));
Y(:,3) = F_3(Vm(:,1),Vm(:,2));

for i=1:n
    % utolsó paraméterként az kéne, hogy amúgy az R^{2} --> R^{3}
    % függvényünk hova képzi a pontot. (azaz a beágyazás inverzfüggvénye)
    c(1,i) = CalculateDot21(Vm,Fm,Out_a(:,i),Y(:,1));
    c(2,i) = CalculateDot21(Vm,Fm,Out_a(:,i),Y(:,2));
    c(3,i) = CalculateDot21(Vm,Fm,Out_a(:,i),Y(:,3));
end

displayEmbedding(Va,Fa)
pause();
y = (c*Ea)';
displayObj(y,Fa)
end


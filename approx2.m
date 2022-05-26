function approx2(Vm,Va,V,Fm,Ea,E)
% Legjobb kozelites eloallitasa
%   Vm : mergelt alappontrendszer
%   Fm : mergelt alappontrendszerhez tartozó lapok
%   Va : kis elemszamu, approximalo alappontrendszer
%   V : meshunk beagyazasa
%   Ea : ortonormalt rendszer, az approximalo alappontrendszerrel
%   E : ortonormalt rendszer, az eredeti meshunk szerint

Out_a = evaluateBaseFunctionsOnMesh(Vm,Ea,Va);
Out = evaluateBaseFunctionsOnMesh(Vm,E,V);
n = size(Vm,1);
for i=1:n
    % utolsó paraméterként az kéne, hogy amúgy az R^{2} --> R^{3}
    % függvényünk hova képzi a pontot. (azaz a beágyazás inverzfüggvénye)
    dp = CalculateDot21(Vm,Fm,Out(i,:),)
end
end


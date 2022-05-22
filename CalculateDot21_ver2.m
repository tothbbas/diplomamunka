function [I] = CalculateDot21_ver2(V,F,y,z) 
%CalculateIntegral : integrálszámítás
%   V : vertexek
%   F : lapok
%   y : fgvértékek
%   z : fgvértékek
%   OUT : skaláris szorzat

r = V(F(:,1),:)-V(F(:,3),:);
s = V(F(:,2),:)-V(F(:,3),:);
doubleAreas = abs(r(:,1).*s(:,2) - r(:,2).*s(:,1));
I = 0;
coeffs = [2 1 1; 1 2 1; 1 1 2];
for i = 1:length(F)
    triangle = F(i,:);
    f_vec = [y(triangle(1)),y(triangle(2)),y(triangle(3))];
    g_vec = [z(triangle(1)),z(triangle(2)),z(triangle(3))]';
    I = I + 1/24 * doubleAreas(i) * (f_vec * coeffs * g_vec);
end

end


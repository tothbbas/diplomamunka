function [I] = CalculateDot21(V,F,f,g) 
%CalculateIntegral : integrálszámítás
%   V : vertexek
%   F : lapok
%   OUT : integrál

r = V(F(:,1),:)-V(F(:,3),:);
s = V(F(:,2),:)-V(F(:,3),:);
doubleAreas = r(:,1).*s(:,2) - r(:,2).*s(:,1);
I = 0;
coeffs = [2 1 1; 1 2 1; 1 1 2];
for i = 1:length(F)
    triangle = F(i,:);
    f_vec = [f(V(triangle(1),1),V(triangle(1),2)), f(V(triangle(2),1),V(triangle(2),2)), f(V(triangle(3),1),V(triangle(3),2))];
    g_vec = [g(V(triangle(1),1),V(triangle(1),2)); g(V(triangle(1),1),V(triangle(1),2)); g(V(triangle(1),1),V(triangle(1),2))];
    I = I + 1/24 * doubleAreas(i) * (f_vec * coeffs * g_vec);
end

end


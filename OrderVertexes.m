function [V,F,B] = OrderVertexes(V,F,B)
% rendezzük a vertexeket úgy, hogy először a belső, majd a határpontok
% szerepeljenek a mátrixban
%   V : vertexek
%   F : lapok
%   B : határvertexek indexei

new_boundary_indices = (length(V)-length(B):length(V));
NEW = setdiff(new_boundary_indices,intersect(B,new_boundary_indices))'; % boundary_indxek amik helyben maradnak
OLD = intersect(B,(1:length(V)-length(B)));
if length(NEW) == length(OLD)
    for i = 1:length(NEW)
        % swap lines in vertex array
        V([NEW(i) OLD(i)],:) = V([OLD(i) NEW(i)],:);
        % swap index in boundary indices
        B(B == NEW(i)) = -1;
        B(B == OLD(i)) = NEW(i);
        B(B == -1) = OLD(i);
        % swap indices in Faces
        F(F == NEW(i)) = -1;
        F(F == OLD(i)) = NEW(i);
        F(F == -1) = OLD(i);
    end
end
end


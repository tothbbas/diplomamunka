function E = ons21(V,F)
tic
% Ortonormált rendszer létrehozása
n = length(V);
Y = eye(n);
for i=1:n
   Y(i,:) = Y(i,:)/sqrt(CalculateDot21(V,F,Y(i,:),Y(i,:)));
end

%Lowdin
S=zeros(n,n);
for i=1:n
    neighbor_indexes = getVertexNeighbors(i,F);
    neighbor_indexes = [neighbor_indexes;i];
    for j=1:length(neighbor_indexes)
        dp = CalculateDot21(V,F,Y(neighbor_indexes(j),:),Y(i,:));
        S(i,neighbor_indexes(j)) = dp;

    end
end

[U,D]=eig(S);
T=U/sqrt(D)*U';
E=T*Y;

toc
end


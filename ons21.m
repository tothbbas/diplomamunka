function E = ons21(V,F)
% Ortonormált rendszer létrehozása
n = length(V);
Y = eye(n);
Y(:,:,2) = eye(n);
for i=1:n
   %neighbor_indexes = getVertexNeighbors(i,F);
   %neighbors = V(neighbor_indexes,:);
   %examined_vertex = V(i,:);
   %neighbors = [neighbors;examined_vertex];
   %values = zeros(1,length(neighbors));
   %values(length(neighbors)) = 1;
   %f = scatteredInterpolant(neighbors(:,1),neighbors(:,2),values','linear','nearest');
   Y(i,:,:) = Y(i,:,:)/sqrt(CalculateDot21(V,F,Y(i,:,:),Y(i,:,:)));
   %
   
   %[xx,yy] = meshgrid(linspace(-1,1,100));
   %surf(xx,yy,f(xx,yy));
   %pause();
end

S=zeros(n,n,n);
for i=1:n
    neighbor_indexes = getVertexNeighbors(i,F);
    neighbor_indexes = [neighbor_indexes,i];
    for j=1:length(neighbor_indexes)
        dp = CalculateDot21(V,F,Y(neighbor_indexes(j),:,:),Y(i,:,:));
        % f? g? a függvény function handle-ökre van definiálva
        % viszont Y nem function handle. scattered interpolant?
        
        % S(i,j)=pldot(t,Y(j,:),Y(i,:));

    end
end
[U,D]=eig(S);
T=U/sqrt(D)*U';
E=T*Y;


end


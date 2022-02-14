function [outV,outF,boundaryV] = deleteVertexAndCorrespondingFaces(inV,inF,idx)
% Egy, az index-szel megadott vertex és a hozzá tartozó lapok törlése
%   inV : bemeneti vertexek (n*3)
%   inF : bemeneti lapok (n*3)
%   idx : törlendő vertex indexe
%   outV : kimeneti vertexek ((n-1)*3)
%   outF : kimeneti lapok ((n-1)*3)
%   boundaryV : a törölt vertex szomszédjainak indexe (k*3)
%   fontos megjegyezni, hogy a törlés hatására, a vertexek indexelése
%   megváltozhat!

% boundaryV
lineindexes = any(inF == idx, 2);   % sorindexek, amikben szerepel a megadott vertex
lines = inF(lineindexes,:);         % sorok
neighborvertices = unique(lines);   % szomszédos csúcsok és az idx csúcs
boundaryV = neighborvertices(neighborvertices ~= idx);  % csak szomszédos csúcsok
boundaryV(boundaryV == length(inF)) = idx;  
% az idx-ediket töröljük és betesszük oda az utolsót, így az utolsó elemet átindexeljük a törölt sorra. lsd.: továbbiak

% Töröljük azon lapokat, amikhez hozzátartozik a törölt csúcs
outF = inF(~any(inF == idx,2),:);
if idx == 1
    % Az utolsó sor bekerül az első helyére.
    outV = [inV(length(inV),:); inV(2:length(inV)-1,:)];
    outF(outF == length(inV)) = idx;
elseif idx == length(inV)
    % Elég az utolsó sort kitörölnünk
    outV = inV(1:length(inV)-1,:);
else
    % A törölt helyre betesszük az eddigi indexeink
    outV = [inV(1:idx-1,:); inV(length(inV),:); inV(idx+1:length(inV)-1,:)];
    outF(outF == length(inV)) = idx;
end
end


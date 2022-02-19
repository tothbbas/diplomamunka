function n = getNumberOfNeighbors(idx,F)
% Megadja egy csúcs szomszédjainak számát
%   idx : csúcs indexe
%   F : faces (lapok mátrixa)

n = length(unique(F(sum(F == idx, 2) > 0, :)));

end


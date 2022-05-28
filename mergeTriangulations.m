function [Vout,Fout] = mergeTriangulations(V1,F1,V2,F2,plot)
%   Háromszögelések összemetszése
    if plot
        triplot(F1,V1(:,1),V1(:,2),'r-');
        hold on
        triplot(F2,V2(:,1),V2(:,2),'b-');
        pause();
    end
    [Vout,Fout] = merge_triangulations(V1,F1,V2,F2);
    if plot
        triplot(Fout,Vout(:,1),Vout(:,2),'k-');
        hold off
    end
end


function ons = checkIfInputIsONS(V,F,E)

n = length(V);
ons = true;
eps = 0.0000000001;
for i=1:n
    for j=i+1:n
        if CalculateDot21_ver2(V,F,E(i,:),E(j,:)) > eps
           ons = false;
           return;
        end
    end
end

end


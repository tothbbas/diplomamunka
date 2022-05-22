function ons = checkIfInputIsONS(V,F,E)
tic
n = length(V);
ons = true;
eps = 0.0000000001;
check_ii = true;
for i=1:n
    if check_ii &&(abs(CalculateDot21_ver2(V,F,E(i,:),E(i,:)) - 1) > eps)
       ons = false;
       return;
    end
    for j=i+1:n
        if CalculateDot21_ver2(V,F,E(i,:),E(j,:)) > eps
           ons = false;
           return;
        end
    end
end
toc
end


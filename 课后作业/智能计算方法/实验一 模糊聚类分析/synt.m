function ab = synt(a)
[hei, wid] = size(a);
ab = zeros(hei, wid);
flag = 0;
while(flag == 0) 
    m = size(a, 1);
    n = size(a, 2);
    for i = 1: m
        for j = 1 :n 
            ab(i, j) = max(min([a(i, :);a(:, j)']));
        end
    end
    if(ab == a)
        flag = 1;
    else
        a = ab;
    end
end
end
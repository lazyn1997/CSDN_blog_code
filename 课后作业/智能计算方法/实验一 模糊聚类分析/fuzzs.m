function m = fuzzs(n)
[hei, wid] = size(n);
 m = zeros(hei, hei);
 for i = 1: hei
        for j = 1: hei
            maxnum = 0;
            minnum = 0;
            for k = 1: wid
                maxnum = maxnum + max(n(i, k), n(j, k));
                minnum = minnum + min(n(i, k), n(j, k));
            end
            m(i, j) = minnum/maxnum;
        end
 end
 end
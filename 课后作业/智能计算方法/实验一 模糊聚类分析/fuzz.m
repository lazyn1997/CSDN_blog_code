function n = fuzz(A)
[hei, wid] = size(A);
 n = zeros(hei, wid);
 for i = 1: hei
        for j = 1: wid
            n(i, j) = (A(i, j) - min(A(:, j)))/(max(A(:, j)) - min(A(:,j)));
        end
 end
 end
function[D, k] = jjz4(b)
L = unique(b)';
a = size(b);
D = zeros(a);
for m = length(L): -1 : 1
    k = L(m);
    for i = 1: a 
        for j = 1: a 
            if b(i, j) >= k 
                D(i, j) = 1;
            else
                D(i, j) = 0;
            end
        end
    end
    B = unique(D, 'rows');
    [hei] = size(B);
    for j = 1: hei
        eval(['L', num2str(j) '= [];'])
    end
    for i = a: -1: 1
        for j = 1: hei
            if D(i, :) == B(j, :)           
                p = eval(['L', num2str(j);]);
                p = [['x', num2str(i), ' '] p];
                eval(['L', num2str(j) '= p;']);
            end
        end
    end
    fprintf("������ϵ��k=%5.4fʱ��", L(m));
    fprintf("���ýؾ���Ϊ��\n\n");
    disp(D);
    fprintf("������Ϊ��\n");
    for j = 1: hei
        fprintf("��%d�ࣺ", j);
        disp(eval(['L', num2str(j);]));
    end
    fprintf("\n");
end
end
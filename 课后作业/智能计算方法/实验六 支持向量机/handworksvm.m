clc;
clear;
C = 10;
kertype = 'rbf';

%ѵ������
X = xlsread('student.xlsx', 'B2: C261')';
Y = xlsread('student.xlsx', 'D2: D261')';
figure;
%x1�洢�������,y1�洢��������,x2�洢Ů�����,y2�洢Ů������
[x1, x2, y1, y2] = deal([]);
[k1, k2] = deal(1);
[~, col] = size(Y);
for i = 1: col
    if Y(1, i) == 1
        x1(k1) = X(1, i);
        y1(k1) = X(2, i);
        k1 = k1 + 1;
    else
        x2(k2) = X(1, i);
        y2(k2) = X(2, i);
        k2 = k2 + 1;
    end
end
plot(x1(1, :), y1(1, :), 'bx', x2(1, :), y2(1, :), 'r*');
xlabel('���');
ylabel('����');
hold on;

%����֧������
svm = svmTrain(X, Y, kertype, C);
plot(svm.Xsv(1, :), svm.Xsv(2, :), 'ko');


%���Ʒ�����
[x1, x2] = meshgrid(160: 0.05: 175, 49: 0.05: 80);
[rows, cols] = size(x1);
nt = rows*cols;                  
Xt = [reshape(x1, 1, nt); reshape(x2, 1, nt)];
Yt = ones(1, nt);
result = svmTest(svm, Xt, Yt, kertype);
Yd = reshape(result.Y, rows, cols);
contour(x1, x2, Yd, 'm');
legend('����', 'Ů��', '֧������', '������', 'Location', 'northwest');

%��������
testx = [162 56; 172 75]';
testy = [-1; 1]';
test = svmTest(svm, testx, testy, kertype);
[~, col] = size(test.Y);
for i = 1: col
    if test.Y(:, i) == 1
        disp(['���' num2str(testx(1, i)) '���ף�����' num2str(testx(2, i)) 'ǧ��Ԥ��Ϊ����']);
    else
        disp(['���' num2str(testx(1, i)) '���ף�����' num2str(testx(2, i)) 'ǧ��Ԥ��ΪŮ��']);
    end
end
disp(['Ԥ����ȷ��Ϊ' num2str(test.accuracy)]);
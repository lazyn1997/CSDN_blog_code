clc;
clear;
C = 10;
kertype = 'rbf';

%训练样本
X = xlsread('student.xlsx', 'B2: C261')';
Y = xlsread('student.xlsx', 'D2: D261')';
figure;
%x1存储男生身高,y1存储男生体重,x2存储女生身高,y2存储女生体重
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
xlabel('身高');
ylabel('体重');
hold on;

%绘制支持向量
svm = svmTrain(X, Y, kertype, C);
plot(svm.Xsv(1, :), svm.Xsv(2, :), 'ko');


%绘制分类线
[x1, x2] = meshgrid(160: 0.05: 175, 49: 0.05: 80);
[rows, cols] = size(x1);
nt = rows*cols;                  
Xt = [reshape(x1, 1, nt); reshape(x2, 1, nt)];
Yt = ones(1, nt);
result = svmTest(svm, Xt, Yt, kertype);
Yd = reshape(result.Y, rows, cols);
contour(x1, x2, Yd, 'm');
legend('男生', '女生', '支持向量', '分类线', 'Location', 'northwest');

%测试数据
testx = [162 56; 172 75]';
testy = [-1; 1]';
test = svmTest(svm, testx, testy, kertype);
[~, col] = size(test.Y);
for i = 1: col
    if test.Y(:, i) == 1
        disp(['身高' num2str(testx(1, i)) '厘米，体重' num2str(testx(2, i)) '千克预测为男生']);
    else
        disp(['身高' num2str(testx(1, i)) '厘米，体重' num2str(testx(2, i)) '千克预测为女生']);
    end
end
disp(['预测正确率为' num2str(test.accuracy)]);
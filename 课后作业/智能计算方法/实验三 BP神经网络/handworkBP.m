clear;
clc;

%训练模块
data = xlsread('student.xlsx');
P0 = data(:, 3 : 4);
T = data(:, 5);
[pn, minp, maxp] = premnmx(P0');
P = pn';
col = size(P, 1);
w = -1.2 + 2.4*rand(1, 6);
[miu, v, E] = deal(zeros(1, 3));
b = -0.5 + rand(1, 3);
yita = 0.01;
goal = 0.001;
error = [];
for epochs = 1: 2000
    s = [];
    for k = 1: col
        miu(1) = P(k, 1)*w(1) + P(k, 2)*w(2) + b(1);
        v(1) = 1/(1 + exp(-miu(1)));
        miu(2) = P(k, 1)*w(3) + P(k, 2)*w(4) + b(2);
        v(2) = 1/(1 + exp(-miu(2)));
        miu(3) = v(1)*w(5) + v(2)*w(6) + b(3);
        v(3) = 1/(1 + exp(-miu(3)));
        E(3) = v(3)*(1 - v(3))*(T(k) - v(3));
        E(2) = v(2)*(1 - v(2))*E(3)*w(6);
        E(1) = v(1)*(1 - v(1))*E(3)*w(5);
        w(6) = w(6) + yita*E(3)*v(2);
        w(5) = w(5) + yita*E(3)*v(1);
        for m = 1: 4
            w(m) = w(m) + yita*E(ceil(m/2))*P(k, 2-rem(m,2));
        end
        b = b + yita*E;
        s = [s, v(3)];
    end
    error0 = mse(s - T');
    if error0 <goal
        break
    else
        error = [error error0];
    end
end
figure;
%绘制迭代结束时预测结果分布图
for n = 1: size(s, 2)  
    if s(n)>0.5
        plot(n, s(n), '+');
        hold on;
    else
        plot(n, s(n), 'o');
        hold on;
    end
end
%绘制最大均方误差曲线图
figure;
plot(1:size(error, 2), error);

%测试模块
output = [];
testp0 = [162 56; 172 75];
[testpn] = premnmx(testp0', 1);
testp = testpn';
for testk = 1: 2
    miu(1) = testp(testk, 1)*w(1) + testp(testk, 2)*w(2) + b(1);
    v(1) = 1/(1 + exp(-miu(1)));
    miu(2) = testp(testk, 1)*w(3) + testp(testk, 2)*w(4) + b(2);
    v(2) = 1/(1 + exp(-miu(2)));
    miu(3) = v(1)*w(5) + v(2)*w(6) + b(3);
    v(3) = 1/(1 + exp(-miu(3)));
    output = [output, v(3)];
end
disp("预测结果为：");
disp(output);

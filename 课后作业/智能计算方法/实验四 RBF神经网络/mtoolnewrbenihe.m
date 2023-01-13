clc;
clear;
P = -9: 1: 8;
T = [-129 -32 -118 -138 -125 -97 -55 -23 -4 2 1 -31 -72 -121 -142 -174 -155 -77];
spread = 0.5;
tic;
net = newrbe(P, T, spread);
test = -9: .1: 8;
out = sim(net, test);
toc;
figure;
plot(P, T, 'o')
hold on;
plot(test, out, 'b-');
legend('输入的数据', '拟合的函数');

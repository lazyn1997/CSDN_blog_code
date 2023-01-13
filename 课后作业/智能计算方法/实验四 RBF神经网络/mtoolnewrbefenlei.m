clc
clear
P = [0, 0, 1, 1; 0, 1, 0, 1];
T = [0, 1, 1, 0];
%创建正规化网络
net = newrbe(P, T);
out = sim(net, P);
disp('训练输出');
disp(out);
P1 = [0.95 0.92; 0.03 0.89];
out1 = sim(net, P1);
disp('测试输出')
disp(out1);

clc
clear
P = [0, 0, 1, 1; 0, 1, 0, 1];
T = [0, 1, 1, 0];
%�������滯����
net = newrbe(P, T);
out = sim(net, P);
disp('ѵ�����');
disp(out);
P1 = [0.95 0.92; 0.03 0.89];
out1 = sim(net, P1);
disp('�������')
disp(out1);

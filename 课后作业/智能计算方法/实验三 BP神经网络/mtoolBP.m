clear;
clc;
data = xlsread('student.xlsx');
P = data(:, 3 : 4);
T = data(:, 5);
%premnmx(P', T')对P'，T'进行归一化处理
[pn, minp, maxp, tn, mint, maxt] = premnmx(P', T');
p1 = pn(:, 1: 260);
t1 = tn(:, 1: 260);
%反归一化还原成原始的数据
pn1 = postmnmx(p1, minp, maxp);
tn1 = postmnmx(t1, mint, maxt);
p = [162 172; 56 75];
t = [0 1];
[p2, minp1, maxp1, t2, mint1, maxt1] = premnmx(p, t);
pn2 = postmnmx(p2, minp1, maxp1);
tn2 = postmnmx(t2, mint1, maxt1);
net = newff(minmax(p1),[2,1],{'tansig','purelin'},'trainrp');
net.trainParam.epochs = 1000;
net.trainParam.goal = 0.00001;
net.trainparam.lr = 0.01;
net = train(net,p1,t1);
%调用matlab神经网络工具箱自带的sim函数得到网络的预测值
y1 = sim(net,p1);
tfz = postmnmx(y1,mint,maxt); 
tfz1 = tfz';
%disp展示变量内容
disp(tfz);
disp(tn1);
temp1 = sim(net,p2);
t_tfz = postmnmx(temp1,mint,maxt);
txl1 = t_tfz';
disp(t_tfz);
disp(tn2);
y_t1 = temp1(1,:);
%计算相对逼近误差
error1=y1-t1(1,:);
%计算相对预测误差
error3 = y_t1-t2(1,:);
figure;
%绘制预测误差曲线
plot(1:260,error1,'r');
title("相对逼近误差");
figure;
plot(1:2,error3,'b');
title("相对预测误差");
figure;
plot(1: 260, tfz, 'r+');
hold on;
plot(1: 260, T, 'bx');
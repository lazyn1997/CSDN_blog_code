clc;
clear;
T = [1 -1 1; -1 1 -1]';
axis([-1 1 -1 1 -1 1]);
set(gca, 'box', 'on');
axis manual;
hold on;
plot3(T(1, :), T(2, :), T(3, :), 'rp');
title('����������Ԫ��Hopfield����״̬�ռ�');
xlabel('a(1)');
ylabel('a(2)');
zlabel('a(3)');
view([-36 30]);
%�������
net = newhop(T);
% % ���ѡȡ��ʼ�㣬���棬���Ӧ���ȶ�������ƽ���֮һ��
% a = {rands(3, 1)};
% [y, Pf, Af] = sim(net, {1, 10}, {}, a);
% record = [cell2mat(a) cell2mat(y)];  %�ϲ�����
% start = cell2mat(a);
% hold on;
% plot3(start(1, 1), start(2, 1), start(3, 1), 'b+', record(1, :), record(2, :), record(3, :));
%���ѡȡ25����ʼ����и�ֵ���۲�����
color = 'rgbmy';
for i = 1: 50
    a={rands(3, 1)};
    [y, Pf, Af] = sim(net, {1, 5}, {}, a);
    record = [cell2mat(a) cell2mat(y)];
    start = cell2mat(a);
    plot3(start(1, 1), start(2, 1), start(3, 1), 'k+', record(1, :), record(2, :), record(3, :), color(rem(i, 5) + 1));
end
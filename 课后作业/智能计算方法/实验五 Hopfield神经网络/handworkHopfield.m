clc;
clear;
T = [1 -1 1; -1 1 -1]';
[n, m] = size(T);
%计算网络权值
w = zeros(n, n);
for i = 1: m
    w = w + T(:, i)*T(:, i)';
end
w = (1/3)*(w - m*eye(n, n));
axis([-1 1 -1 1 -1 1]);
set(gca, 'box', 'on');
axis manual;
plot3(T(1, :), T(2, :), T(3, :), 'rp');%rp表示红色五角星
title('含有三个神经元的Hopfield网络状态空间');
xlabel('a(1)'); ylabel('a(2)'); zlabel('a(3)'); view([-36 30]); hold on;
%随机选取50个数进行仿真
for m = 1: 50
    v1 = rands(3);
    v0 = v1;
    n = length(v0);
    v = zeros(n, 1);
    while(sum(v ~= v0)~=0 || sum(abs(v0) - ones(n, 1)) ~= 0)
        v = v0;
        i = randi(n);
        if(w(i, :)*v0<0)     
            v0(i, :) = -1;
        else
            v0(i, :) = 1;
        end
    end
    track = [v1 v0];
    plot3(v1(1, 1), v1(2, 1), v1(3, 1), 'k+', track(1, :), track(2, :), track(3, :));
    hold on;
end
 
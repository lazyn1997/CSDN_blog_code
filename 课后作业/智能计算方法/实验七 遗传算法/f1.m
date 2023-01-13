%optimtool调出界面，选择ga即为遗传算法
function z = f1(x)
a = (x(1) - 3.5).^2;
b = (x(2) + 4).^2;
z = a + b;
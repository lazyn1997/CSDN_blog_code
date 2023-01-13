clc;
clear;

%%单变量
% bn = 22;
% inn = 50; %初始种群大小
% gnmax = 500;  %最大代数
% pc = 0.75; %交叉概率
% pm = 0.05; %变异概率
% %产生初始种群
% s = round(rand(inn, bn));
% [f, p] = objf(s);
% gn = 1;
% while gn < gnmax + 1
%    for j = 1: 2: inn
%       seln = sel(s, p);  %选择操作
%       scro = cro(s, seln, pc);  %交叉操作
%       scnew(j, :) = scro(1, :); 
%       scnew(j + 1, :) = scro(2, :);
%       smnew(j, :) = mut(scnew(j, :), pm); %变异操作
%       smnew(j + 1, :) = mut(scnew(j + 1, :), pm);
%    end
%    s = smnew;  %产生了新的种群
%    [f, p] = objf(s);  %计算新种群的适应度
%    %记录当前代最好和平均的适应度
%    [fmax, nmax] = max(f);
%    fmean = mean(f);
%    ymax(gn) = fmax;
%    ymean(gn) = fmean;
%    %记录当前代的最佳个体
%    x = bin2dec(num2str(s(nmax, :)));
%    xx = 9*x/(power(2, bn)-1);
%    xmax(gn) = xx;
%    gn = gn + 1;
% end
% gn = gn - 1;
% %绘制曲线
% subplot(2, 1, 1);
% plot(1: gn, [ymax; ymean]);
% title('历代适应度变化', 'FontSize', 10);
% legend('最大适应度', '平均适应度', 'Location', 'southeast');
% string1 = ['最终适应度为', num2str(ymax(gn))];
% subplot(2, 1, 2);
% plot(1: gn, xmax, 'r-');
% legend('自变量', 'Location', 'southeast');
% string2 = ['最终自变量为', num2str(xmax(gn))];
% gtext(string1);
% gtext(string2);
% 
% function y = ft(x)
% y = x + 10*sin(5*x) + 7*cos(4*x);
% end
% 
% %计算所有种群的适应度
% function [f, p] = objf(s)
% r = size(s);  %读取种群大小
% inn = r(1);
% bn = r(2);
% for i = 1: inn
%     x = bin2dec(num2str(s(i, :))); %将二进制转换为十进制
%     xx = 9*x/(power(2, bn)-1); %转化为[0，9]区间的实数
%     f(i) = ft(xx); %计算函数值，即适应度
% end
% f = f'; %取距离倒数
% %根据个体的适应度计算其被选择的概率
% fsum = 0;
% for i = 1: inn
%    fsum = fsum + f(i)*f(i);% 让适应度越好的个体被选择概率越高
% end
% for i = 1: inn
%    ps(i) = f(i)*f(i)/fsum;
% end
% %计算累积概率
% p(1) = ps(1);
% for i = 2: inn
%    p(i) = p(i-1) + ps(i);
% end
% p = p';
% end

%%双变量
[ymax1, ymean1, xmax1, ~] = solver(1);
[ymax2, ymean2, xmax2, gn] = solver(2);
ymax = - (ymax1 + ymax2 - 42.25 - 196);
ymean = - (ymean1 + ymean2 - 42.25 - 196);
gn = gn - 1;
%绘制曲线
subplot(3, 1, 1);
plot(1: gn, [ymax; ymean]);
title('历代适应度变化', 'FontSize', 10);
legend('最大适应度', '平均适应度', 'Location', 'southeast');
string1 = ['最终适应度为', num2str(ymax(gn))];
subplot(3, 1, 2);
plot(1: gn, xmax1, 'r-');
legend('自变量x', 'Location', 'southeast');
string2 = ['最终自变量x为', num2str(xmax1(gn))];
subplot(3, 1, 3);
plot(1: gn, xmax2, 'g-');
legend('自变量y', 'Location', 'southeast');
string3 = ['最终自变量y为', num2str(xmax2(gn))];
gtext(string1);
gtext(string2);
gtext(string3);

%定义求解器
function [ymax, ymean, xmax, gn] = solver(a)
inn = 50; %初始种群大小
bn = 22;
gnmax = 500;  %最大代数
pc = 0.75; %交叉概率
pm = 0.05; %变异概率
gn = 1;
s = round(rand(inn, bn));
[f, p] = objf(s, a);
while gn < gnmax + 1
   for j = 1: 2: inn
      seln = sel(s, p);  %选择操作
      scro = cro(s, seln, pc);  %交叉操作
      scnew(j, :) = scro(1, :); 
      scnew(j + 1, :) = scro(2, :);
      smnew(j, :) = mut(scnew(j, :), pm); %变异操作
      smnew(j + 1, :) = mut(scnew(j + 1, :), pm);
   end
   s = smnew;  %产生了新的种群
   [f, p] = objf(s, a);  %计算新种群的适应度
   %记录当前代最好和平均的适应度
   [fmax, nmax] = max(f);
   fmean = mean(f);
   ymax(gn) = fmax;
   ymean(gn) = fmean;
   %记录当前代的最佳个体
   x = bin2dec(num2str(s(nmax, :)));
   xx1 = 1 + 9*x/(power(2, bn)-1);
   xmax(gn) = xx1;
   gn = gn + 1;
end
end

%适应度函数1
function y1 = ft1(x1)
y1 = 42.25 - (x1 - 3.5).^2;
end

%适应度函数2
function y2 = ft2(x2)
y2 = 196 - (x2 + 4).^2;
end

%计算所有种群的适应度
function [f, p] = objf(s, a)
r = size(s);  %读取种群大小
inn = r(1);
bn = r(2);
for i = 1: inn
    x = bin2dec(num2str(s(i, :))); %将二进制转换为十进制
    xx = 1 + 9*x/(power(2, bn)-1); %转化为[0，9]区间的实数
    if(a == 1)
        f(i) = ft1(xx);
        f(i) = f(i);
    else
        f(i) = ft2(xx);
        f(i) = f(i);
    end
end
f = f'; %取距离倒数
%根据个体的适应度计算其被选择的概率
fsum = 0;
for i = 1: inn
   fsum = fsum + f(i)*f(i);% 让适应度越好的个体被选择概率越高
end
for i = 1: inn
   ps(i) = f(i)*f(i)/fsum;
end
%计算累积概率
p(1) = ps(1);
for i = 2: inn
   p(i) = p(i-1) + ps(i);
end
p = p';
end

%根据变异概率判断是否变异
function pcc = pro(pc)
test(1: 100) = 0;
l = round(100*pc);
test(1: l) = 1;
n = round(rand*99) + 1;
pcc = test(n);   
end

%“选择”操作
function seln = sel(s, p)
inn = size(p, 1);
%从种群中选择两个个体，最好不要两次选择同一个个体
for i = 1: 2
   r = rand;  %产生一个随机数
   prand = p - r;
   j = 1;
   while prand(j) < 0
       j = j + 1;
   end
   seln(i) = j; %选中个体的序号
   if i == 2 && j == seln(i - 1)    %%若相同就再选一次
       r = rand;  %产生一个随机数
       prand = p - r;
       j = 1;
       while prand(j) < 0
           j = j + 1;
       end
   end
end
end

%“交叉”操作
function scro = cro(s, seln, pc)
[~, bn] = size(s);
pcc = pro(pc);  %根据交叉概率决定是否进行交叉操作，1则是，0则否
scro(1, :) = s(seln(1), :);
scro(2, :) = s(seln(2), :);
if pcc == 1
    chb = round(rand*(bn - 2)) + 1;  %在[1,bn-1]范围内随机产生一个交叉位
    scro(1, :) = [s(seln(1), 1: chb) s(seln(2), chb + 1: bn)];
    scro(2, :) = [s(seln(2), 1: chb) s(seln(1), chb + 1: bn)];
end
end

%“变异”操作
function snnew = mut(snew, pm)
r = size(snew);
bn = r(2);
snnew = snew;
pmm = pro(pm);  %根据变异概率决定是否进行变异操作，1则是，0则否
if pmm == 1
    chb = round(rand*(bn - 1)) + 1;  %在[1,bn]范围内随机产生一个变异位
    snnew(chb) = abs(snew(chb) - 1);
end
end

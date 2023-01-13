clc;
clear;

%%������
% bn = 22;
% inn = 50; %��ʼ��Ⱥ��С
% gnmax = 500;  %������
% pc = 0.75; %�������
% pm = 0.05; %�������
% %������ʼ��Ⱥ
% s = round(rand(inn, bn));
% [f, p] = objf(s);
% gn = 1;
% while gn < gnmax + 1
%    for j = 1: 2: inn
%       seln = sel(s, p);  %ѡ�����
%       scro = cro(s, seln, pc);  %�������
%       scnew(j, :) = scro(1, :); 
%       scnew(j + 1, :) = scro(2, :);
%       smnew(j, :) = mut(scnew(j, :), pm); %�������
%       smnew(j + 1, :) = mut(scnew(j + 1, :), pm);
%    end
%    s = smnew;  %�������µ���Ⱥ
%    [f, p] = objf(s);  %��������Ⱥ����Ӧ��
%    %��¼��ǰ����ú�ƽ������Ӧ��
%    [fmax, nmax] = max(f);
%    fmean = mean(f);
%    ymax(gn) = fmax;
%    ymean(gn) = fmean;
%    %��¼��ǰ������Ѹ���
%    x = bin2dec(num2str(s(nmax, :)));
%    xx = 9*x/(power(2, bn)-1);
%    xmax(gn) = xx;
%    gn = gn + 1;
% end
% gn = gn - 1;
% %��������
% subplot(2, 1, 1);
% plot(1: gn, [ymax; ymean]);
% title('������Ӧ�ȱ仯', 'FontSize', 10);
% legend('�����Ӧ��', 'ƽ����Ӧ��', 'Location', 'southeast');
% string1 = ['������Ӧ��Ϊ', num2str(ymax(gn))];
% subplot(2, 1, 2);
% plot(1: gn, xmax, 'r-');
% legend('�Ա���', 'Location', 'southeast');
% string2 = ['�����Ա���Ϊ', num2str(xmax(gn))];
% gtext(string1);
% gtext(string2);
% 
% function y = ft(x)
% y = x + 10*sin(5*x) + 7*cos(4*x);
% end
% 
% %����������Ⱥ����Ӧ��
% function [f, p] = objf(s)
% r = size(s);  %��ȡ��Ⱥ��С
% inn = r(1);
% bn = r(2);
% for i = 1: inn
%     x = bin2dec(num2str(s(i, :))); %��������ת��Ϊʮ����
%     xx = 9*x/(power(2, bn)-1); %ת��Ϊ[0��9]�����ʵ��
%     f(i) = ft(xx); %���㺯��ֵ������Ӧ��
% end
% f = f'; %ȡ���뵹��
% %���ݸ������Ӧ�ȼ����䱻ѡ��ĸ���
% fsum = 0;
% for i = 1: inn
%    fsum = fsum + f(i)*f(i);% ����Ӧ��Խ�õĸ��屻ѡ�����Խ��
% end
% for i = 1: inn
%    ps(i) = f(i)*f(i)/fsum;
% end
% %�����ۻ�����
% p(1) = ps(1);
% for i = 2: inn
%    p(i) = p(i-1) + ps(i);
% end
% p = p';
% end

%%˫����
[ymax1, ymean1, xmax1, ~] = solver(1);
[ymax2, ymean2, xmax2, gn] = solver(2);
ymax = - (ymax1 + ymax2 - 42.25 - 196);
ymean = - (ymean1 + ymean2 - 42.25 - 196);
gn = gn - 1;
%��������
subplot(3, 1, 1);
plot(1: gn, [ymax; ymean]);
title('������Ӧ�ȱ仯', 'FontSize', 10);
legend('�����Ӧ��', 'ƽ����Ӧ��', 'Location', 'southeast');
string1 = ['������Ӧ��Ϊ', num2str(ymax(gn))];
subplot(3, 1, 2);
plot(1: gn, xmax1, 'r-');
legend('�Ա���x', 'Location', 'southeast');
string2 = ['�����Ա���xΪ', num2str(xmax1(gn))];
subplot(3, 1, 3);
plot(1: gn, xmax2, 'g-');
legend('�Ա���y', 'Location', 'southeast');
string3 = ['�����Ա���yΪ', num2str(xmax2(gn))];
gtext(string1);
gtext(string2);
gtext(string3);

%���������
function [ymax, ymean, xmax, gn] = solver(a)
inn = 50; %��ʼ��Ⱥ��С
bn = 22;
gnmax = 500;  %������
pc = 0.75; %�������
pm = 0.05; %�������
gn = 1;
s = round(rand(inn, bn));
[f, p] = objf(s, a);
while gn < gnmax + 1
   for j = 1: 2: inn
      seln = sel(s, p);  %ѡ�����
      scro = cro(s, seln, pc);  %�������
      scnew(j, :) = scro(1, :); 
      scnew(j + 1, :) = scro(2, :);
      smnew(j, :) = mut(scnew(j, :), pm); %�������
      smnew(j + 1, :) = mut(scnew(j + 1, :), pm);
   end
   s = smnew;  %�������µ���Ⱥ
   [f, p] = objf(s, a);  %��������Ⱥ����Ӧ��
   %��¼��ǰ����ú�ƽ������Ӧ��
   [fmax, nmax] = max(f);
   fmean = mean(f);
   ymax(gn) = fmax;
   ymean(gn) = fmean;
   %��¼��ǰ������Ѹ���
   x = bin2dec(num2str(s(nmax, :)));
   xx1 = 1 + 9*x/(power(2, bn)-1);
   xmax(gn) = xx1;
   gn = gn + 1;
end
end

%��Ӧ�Ⱥ���1
function y1 = ft1(x1)
y1 = 42.25 - (x1 - 3.5).^2;
end

%��Ӧ�Ⱥ���2
function y2 = ft2(x2)
y2 = 196 - (x2 + 4).^2;
end

%����������Ⱥ����Ӧ��
function [f, p] = objf(s, a)
r = size(s);  %��ȡ��Ⱥ��С
inn = r(1);
bn = r(2);
for i = 1: inn
    x = bin2dec(num2str(s(i, :))); %��������ת��Ϊʮ����
    xx = 1 + 9*x/(power(2, bn)-1); %ת��Ϊ[0��9]�����ʵ��
    if(a == 1)
        f(i) = ft1(xx);
        f(i) = f(i);
    else
        f(i) = ft2(xx);
        f(i) = f(i);
    end
end
f = f'; %ȡ���뵹��
%���ݸ������Ӧ�ȼ����䱻ѡ��ĸ���
fsum = 0;
for i = 1: inn
   fsum = fsum + f(i)*f(i);% ����Ӧ��Խ�õĸ��屻ѡ�����Խ��
end
for i = 1: inn
   ps(i) = f(i)*f(i)/fsum;
end
%�����ۻ�����
p(1) = ps(1);
for i = 2: inn
   p(i) = p(i-1) + ps(i);
end
p = p';
end

%���ݱ�������ж��Ƿ����
function pcc = pro(pc)
test(1: 100) = 0;
l = round(100*pc);
test(1: l) = 1;
n = round(rand*99) + 1;
pcc = test(n);   
end

%��ѡ�񡱲���
function seln = sel(s, p)
inn = size(p, 1);
%����Ⱥ��ѡ���������壬��ò�Ҫ����ѡ��ͬһ������
for i = 1: 2
   r = rand;  %����һ�������
   prand = p - r;
   j = 1;
   while prand(j) < 0
       j = j + 1;
   end
   seln(i) = j; %ѡ�и�������
   if i == 2 && j == seln(i - 1)    %%����ͬ����ѡһ��
       r = rand;  %����һ�������
       prand = p - r;
       j = 1;
       while prand(j) < 0
           j = j + 1;
       end
   end
end
end

%�����桱����
function scro = cro(s, seln, pc)
[~, bn] = size(s);
pcc = pro(pc);  %���ݽ�����ʾ����Ƿ���н��������1���ǣ�0���
scro(1, :) = s(seln(1), :);
scro(2, :) = s(seln(2), :);
if pcc == 1
    chb = round(rand*(bn - 2)) + 1;  %��[1,bn-1]��Χ���������һ������λ
    scro(1, :) = [s(seln(1), 1: chb) s(seln(2), chb + 1: bn)];
    scro(2, :) = [s(seln(2), 1: chb) s(seln(1), chb + 1: bn)];
end
end

%�����족����
function snnew = mut(snew, pm)
r = size(snew);
bn = r(2);
snnew = snew;
pmm = pro(pm);  %���ݱ�����ʾ����Ƿ���б��������1���ǣ�0���
if pmm == 1
    chb = round(rand*(bn - 1)) + 1;  %��[1,bn]��Χ���������һ������λ
    snnew(chb) = abs(snew(chb) - 1);
end
end

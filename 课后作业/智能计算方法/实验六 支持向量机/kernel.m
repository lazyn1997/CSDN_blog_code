function K = kernel(X,Y,type)
%X 维数*个数
switch type
case 'linear'
    K = X'*Y;
case 'rbf'
    delta = 5;
    delta = delta*delta;
    XX = sum(X'.*X',2);%sum(a,2)代码中参数2的意思是将a矩阵a中的按“行”为单位进行求和
    YY = sum(Y'.*Y',2);
    XY = X'*Y;
    K = abs(repmat(XX,[1 size(YY,1)]) + repmat(YY',[size(XX,1) 1]) - 2*XY);
    K = exp(-K./delta);
end
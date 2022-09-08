# -*- coding: utf-8 -*-
"""
Created on Sun Apr 21 11:57:22 2019

@author: lazyn
"""

import os
from sklearn.linear_model import LogisticRegression
import numpy as np
import pandas as pd
import warnings
from createPlot import createPlot
import matplotlib.pyplot as plt

warnings.filterwarnings("ignore")


# 定义连续值处理函数
def con_deal(temp_df, a):
    for j in range(0, len(temp_df)):
        temp_df.iat[j] = 0 if (temp_df.iat[j] < a) else 1
    return temp_df


# 定义计算连续值正确率的函数
def con_acc(data, Y):
    a = np.sort(np.array(data))
    a = (a[0: len(a) - 1] + a[1: len(a)]) / 2
    max_acc, ind = 0, 0
    for i in range(0, len(a)):
        temp_df = con_deal(data.copy(), a[i])
        X0 = np.array(temp_df).reshape(-1, 1)
        logreg = LogisticRegression()
        logreg.fit(X0, Y)
        acc = logreg.score(X0, Y)
        if max_acc < acc:
            max_acc = acc
            ind = i
            temp_df0 = X0
    print(round(max_acc, 3), end=', 判断结果为：\n')
    print(logreg.predict(temp_df0))
    return [max_acc, a[ind]]


# 获取根节点函数
def getroot(X1, Y1, m):
    max_acc = 0
    for i in m:
        if i != '密度' and i != '含糖率':
            print(i + '节点, 正确率为', end='：')
            X0 = np.array(X1[i]).reshape(-1, 1)
            logreg = LogisticRegression()
            logreg.fit(X0, Y1)
            acc = logreg.score(X0, Y1)
            print(round(acc, 3), end=', 判断结果为：\n')
            print(logreg.predict(X0))
            if max_acc < acc:
                max_acc = acc
                root = i
        else:
            print(i + '节点, 正确率为', end='：')
            acc = con_acc(X1[i], Y1)[0]
            if max_acc < acc:
                max_acc = acc
                root = i
    return root


# 获取决策树数组函数
def gettree(X, Xo, Y, m):
    n1, n2 = [], []
    root = getroot(X, Y['好瓜'], m)
    print('故选择' + root + '为根节点')
    n1.append(root)
    m.remove(root)
    if root == '密度' or root == '含糖率':
        div = con_acc(X[root], Y['好瓜'])[1]
        X[root], Xo[root], Y[root] = con_deal(X[root], div), con_deal(Xo[root], div), con_deal(X[root], div)
    #    print(X, Xo)
    Attr, Attro = X[root].unique(), Xo[root].unique()
    print(Attr, Attro)
    for j, jo in zip(Attr, Attro):
        n3 = []
        if root == '密度' or root == '含糖率':
            if j >= div:
                key = '≥' + str(div)
            else:
                key = '<' + str(div)
        else:
            key = jo
        print(root + '为' + key + '时：')
        n3.append(key)
        X1 = X[X[root] == j]
        Xo1 = Xo[Xo[root] == jo]
        Y0 = Y[Y[root] == j]
        Y1 = Y0['好瓜']
        if Y1.unique().size > 1:
            Xn, Xon, Yn = X1, Xo1, Y0
            n3.append(gettree(Xn, Xon, Yn, m))
        else:
            flag = '好瓜' if Y1.unique() == '是' else '坏瓜'
            print(flag)
            n3.append(flag)
        n2.append(n3)
    n1 += n2
    return n1


# 数组处理及绘制函数
def dealanddraw(n0, pngname):
    alstr = str(n0)
    alstr = alstr.replace(',', ':')
    alstr = alstr.replace(']: [', ',')
    alstr = alstr.replace(']:', '],')
    alstr = alstr.replace('[', '{')
    alstr = alstr.replace(']', '}')
    inTree = eval(alstr)
    #    print(inTree)
    plt.figure(figsize=(10, 7))
    createPlot(inTree)
    #    dpi, 控制每英寸长度上的分辨率;bbox_inches, 能删除figure周围的空白部分
    plt.savefig(pngname, dpi=400, bbox_inches='tight')
    plt.show()


f = open('watermelon3.txt')
watermelon3_df = pd.read_table(f)
Xo = watermelon3_df[['色泽', '根蒂', '敲声', '纹理', '脐部', '触感', '密度', '含糖率']]
m = list(watermelon3_df.columns)
h = 0.001
for i in m:
    if i != '密度' and i != '含糖率' and i != '好瓜':
        size_mapping = {}
        m0 = watermelon3_df[i].unique()
        j = 1
        for i0 in m0:
            size_mapping[i0] = j
            j += 1
        print(size_mapping)
        watermelon3_df[i] = watermelon3_df[i].map(size_mapping)

X = watermelon3_df[['色泽', '根蒂', '敲声', '纹理', '脐部', '触感', '密度', '含糖率']]
Y = watermelon3_df
m = list(X.columns)
n0 = gettree(X, Xo, Y, m)
pngname = os.path.basename(os.path.realpath(__file__)).replace('py', 'png')
dealanddraw(n0, pngname)

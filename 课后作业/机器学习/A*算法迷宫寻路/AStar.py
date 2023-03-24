# -*- coding: utf-8 -*-
"""
Created on Sat Nov 24 16:47:38 2018

@author: 魅梦
"""
import numpy as np
import time


def h1(i, j):
    return 10 * (abs(i - endx) + abs(j - endy))


def h2(i, j):
    return pow(i - endx, 2) + pow(j - endy, 2)


def gs(i, j):
    return abs(i - startx) + abs(j - starty)


# a = np.mat(np.random.randint(0, 2, size=[10, 10]))
a = np.mat([[0, 0, 0, 0, 0],
            [1, 0, 1, 0, 1],
            [0, 1, 1, 0, 1],
            [0, 1, 1, 0, 0],
            [0, 0, 0, 1, 0]])

# a = np.mat([[0, 0, 0, 0, 0],
#             [1, 0, 1, 0, 1],
#             [0, 0, 1, 1, 1],
#             [0, 1, 0, 0, 0],
#             [0, 0, 0, 1, 0]])

# a = np.mat([[0, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 0, 1, 1, 1, 0, 1, 1, 1, 1],
#             [0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1, 0, 0, 0, 1, 1],
#             [0, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 0, 0, 0, 0, 1, 1, 0, 1, 1],
#             [0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 1, 0, 1, 0, 0, 0, 1, 0, 1, 1],
#             [1, 1, 1, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1, 1, 0, 0, 1, 1],
#             [0, 0, 1, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 0, 1],
#             [0, 1, 0, 1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0, 1, 1],
#             [1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 0, 0, 1, 1, 1, 1, 0, 0, 1],
#             [0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 1, 1, 1, 0, 1],
#             [0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 0, 1, 1, 0, 1, 0],
#             [0, 0, 1, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 0, 0, 0, 1],
#             [0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1],
#             [0, 1, 1, 1, 0, 1, 0, 1, 0, 0, 1, 1, 1, 0, 0, 1, 0, 0, 0, 0],
#             [0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 0, 0, 1],
#             [1, 1, 0, 1, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
#             [0, 0, 1, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1],
#             [0, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0],
#             [0, 1, 0, 0, 1, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
#             [1, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 0, 0, 1, 1, 0],
#             [0, 0, 1, 1, 1, 1, 0, 0, 1, 1, 1, 1, 1, 0, 0, 1, 1, 0, 1, 0]])

print("地图为：（1表示墙，0表示路）")
for l in range(len(a)):
    for m in range(a[0].size):
        print(a[l, m], end=' ')
    print('')
print('')

startx, starty = 1, 1
endx, endy = 4, 4
if a[startx - 1, starty - 1] == 1:
    print("起点%s位置为墙，最短路径寻找失败！" % ([startx, starty]))
else:
    # 存储已扩展结点，即所有寻找的节点
    Close = [[startx, starty]]
    # 存储已生成节点，即最终走过的节点
    Opens = [[startx, starty]]
    # 存储未走的分叉节点
    crossings = []
    # 设置在原地图行走的路径值
    road = 100
    start = time.time()
    rows, cols = a.shape
    while True:
        # 判断最后走过的节点是否为终点
        if Close[-1] != [endx, endy]:
            Open = []
            # 减1得到数组下标值
            i, j = Close[-1][0] - 1, Close[-1][1] - 1
            # 对当前节点上下左右四个节点进行判断
            for ni, nj in [(i - 1, j), (i + 1, j), (i, j - 1), (i, j + 1)]:
                if [ni + 1, nj + 1] not in Opens and 0 <= ni < rows and 0 <= nj < cols and a[ni, nj] == 0:
                    Open.append([ni + 1, nj + 1])
            # 将已走过的节点值修改为路径值，并将路径值加1
            a[i, j] = road
            road = road + 1
            if Open:
                # 对所有扩展到的节点进行排序，reverse=True 结果从大到小，即尾部存储代价最小的节点
                Open = sorted(Open, key=lambda x: gs(x[0], x[1]) + h2(x[0], x[1]), reverse=True)
                Opens.extend(Open)
                # 将代价最小的节点存储到 Close 表
                Close.append(Open.pop())
                # 如果 pop 后 Open 表不为空，说明存在岔路，将岔路存储到 crossings 中
                if Open:
                    crossings.extend(Open)
            # 判断是否存在未走过的分叉节点
            elif crossings:
                next_way = crossings.pop()
                # 实现路径回退，循环条件为回退节点与分叉节点不相邻
                while sum((np.array(Close[-1]) - np.array(next_way)) ** 2) != 1:
                    # 当一条路径寻找失败后，是否将该路径岔路后的部分恢复为原地图
                    # i, j = Close[-1]
                    # a[i-1, j-1] = 0
                    # 每次 while 循环路径值 road 减1，并弹出 Close 表中的节点
                    road -= 1
                    Close.pop()
                # 将 crossings 中最后一个节点添加到 Close 表
                Close.append(next_way)
            else:
                print("最短路径寻找失败，失败位置为：%s，路径为：" % Close[-1])
                break
        else:
            a[endx - 1, endy - 1] = road
            print("最短路径寻找成功，路径为：")
            break
    for r in range(rows):
        for c in range(cols):
            # 0表示format中第一个元素，>表示右对齐输出，4表示占四个字符
            print("{0: >4}".format(a[r, c]), end='')
        print('')
    end = time.time()
    print("\n扩展节点数为：%d, 生成节点数为：%d, 用时为 %.8f" % (len(Opens), len(Close), float(end - start)))

    print('Close表为：%s' % Close)
    print("点的移动轨迹为：")
    for k in range(len(Close)):
        print(Close[k], end='')
        if k < len(Close) - 1:
            print("-->", end='')

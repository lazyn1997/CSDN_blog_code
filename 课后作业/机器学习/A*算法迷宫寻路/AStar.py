import numpy as np
import time


def h1(i, j):
    return 10 * (abs(i - endx) + abs(j - endy))


def h2(i, j):
    return pow(i - endx, 2) + pow(j - endy, 2)


def gs(i, j):
    return abs(i - startx) + abs(j - starty)


def op(Open, i, j, minf):
    global i1
    global j1
    f = gs(i, j) + h2(i, j)
    if [i + 1, j + 1] not in Close:
        Open.append([i + 1, j + 1])
    if f < minf:
        minf = f
        i1 = i
        j1 = j
    return Open, minf


# a = np.mat(np.random.randint(0, 2, size=[10, 10]))
a = np.mat([[0, 0, 0, 0, 0],
            [1, 0, 1, 0, 1],
            [0, 0, 1, 1, 1],
            [0, 1, 0, 0, 0],
            [0, 0, 0, 1, 0]])
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
b = a
startx, starty = 1, 1
i, j = startx - 1, starty - 1
endx, endy = 4, 4
Open, Close = [[startx, starty]], [[startx, starty]]
Opens = [[startx, starty]]
road = 100
start = time.time()

while Open:
    if a[startx - 1, starty - 1] == 1:
        print("最短路径寻找失败，失败位置为：", Close[-1], ", 点的移动轨迹为：")
        break
    if Open[-1] != [endx, endy]:
        Open = []
        minf = 10000
        if i + 1 < len(a) and a[i + 1, j] == 0:
            Open, minf = op(Open, i + 1, j, minf)
        if i - 1 >= 0 and a[i - 1, j] == 0:
            Open, minf = op(Open, i - 1, j, minf)
        if j + 1 < len(a) and a[i, j + 1] == 0:
            Open, minf = op(Open, i, j + 1, minf)
        if j - 1 >= 0 and a[i, j - 1] == 0:
            Open, minf = op(Open, i, j - 1, minf)
        b[i, j] = road
        road = road + 1
        if Open:
            i, j = i1, j1
            Close.append([i + 1, j + 1])
            Opens.extend(Open)
    else:
        end = time.time()
        b[endx - 1, endy - 1] = road
        print("最短路径寻找成功，路径为：")
        for l in range(len(b)):
            for m in range(b[0].size):
                # 0表示format中第一个元素，>表示右对齐输出，3表示占三个字符
                print("{0: >4}".format(b[l, m]), end='')
            print('')
        print("扩展节点数为：", len(Opens))
        print("生成节点数为：", len(Close))
        print('用时为:', end - start)
        print('Close表为:', Close)
        print("点的移动轨迹为：")
        break
if not Open:
    print("最短路径寻找失败，失败位置为：", Close[-1], ", 点的移动轨迹为：")
for k in range(len(Close)):
    print(Close[k], end='')
    if k < len(Close) - 1:
        print("-->", end='')

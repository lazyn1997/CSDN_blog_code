# -*- coding: utf-8 -*- 
# @Time : 2025/3/11 17:48 
# @Author : lazyn
# @File : proximity_inverted_index_search.py 
# @Software :PyCharm Community Edition
def createdict(f0):
    """
    根据输入文本构建单词位置索引字典

    参数：
        f0 (str): 输入文本字符串，包含多行文本内容

    返回值：
        dict: 双层嵌套字典结构，外层键为单词，值为字典。
              内层字典键为行号(从1开始)，值为该单词在该行出现的列位置列表(从1开始)
    """
    # 生成去重后的单词列表（排除空字符串）
    dl = list(set(re.split('[ \n?!,.;]', f0)))
    dl.pop(0)  # 移除分割产生的首空字符

    # 按行分割原始文本
    d = f0.split('\n')

    dict1 = {}  # 临时存储单词语句位置信息
    dict0 = {}  # 主字典存储最终结果

    # 遍历每个单词构建位置索引
    for word in dl:
        # 逐行扫描单词出现位置
        for i in range(len(d)):
            # 分割当前行获取单词位置
            d0 = re.split('[ \n?!,.;]', d[i])

            # 记录单词在当前行的列位置
            if word in d0:
                dict1[i + 1] = []
                # 收集单词在行中的具体位置
                for j in range(len(d0)):
                    if word == d0[j]:
                        dict1[i + 1].append(j + 1)

        # 将当前单词的位置信息存入主字典
        dict0[word] = dict1
        dict1 = {}  # 重置临时字典

    return dict0


def PositionalIntersect(p1, p2, k):
    """
    查找两个位置列表的位置交叉点

    参数:
    p1 (dict): 第一个位置字典，格式为{term: [positions]}，如{"apple": [1,5,8]}
    p2 (dict): 第二个位置字典，格式与p1相同
    k (int): 允许的最大位置间隔阈值

    返回值:
    list: 包含所有满足位置间隔条件的匹配项，每个元素格式为[term, position1, position2]
    """
    r = []
    # 提取两个字典的键列表（要求字典键已排序）
    k1, k2 = [key for key in p1], [key for key in p2]
    i, j = 0, 0

    # 双指针遍历两个键列表（类似合并有序链表逻辑）
    while (i < len(p1) and j < len(p2)):
        if (k1[i] == k2[j]):
            l = []
            pp1, pp2 = p1[k1[i]], p2[k2[j]]
            i1, j1 = 0, 0

            # 处理相同term的位置列表
            while (i1 < len(pp1)):
                # 寻找pp2中与pp1[i1]邻近的位置（差值<=k）
                while (j1 < len(pp2)):
                    if (abs(pp1[i1] - pp2[j1]) <= k):
                        l.append(pp2[j1])
                    elif (pp2[j1] > pp1[i1]):
                        break
                    j1 = j1 + 1

                # 维护滑动窗口，移除超出范围的位置
                while (l != [] and abs(l[0] - pp1[i1]) > k):
                    del (l[0])

                # 生成所有有效位置对
                for n in range(0, len(l)):
                    r.append([k1[i], pp1[i1], l[n]])
                i1 = i1 + 1

            i = i + 1
            j = j + 1
        elif (k1[i] > k2[j]):
            # 移动较小键的指针
            j = j + 1
        else:
            i = i + 1
    return r


import re

p1 = {1: [7, 18, 33, 72, 86, 231], 2: [1, 17, 74, 222, 255], 4: [8, 16, 190, 429, 433], 5: [363, 367], 7: [13, 23, 191]}
p2 = {1: [17, 25], 4: [17, 191, 291, 430, 434], 5: [14, 19, 101]}
f = open("document.txt", "r")
f0 = f.read()
f.close()
dict0 = createdict(f0)
k = [key for key in dict0]
print("可供查询的词项为：", k, "\n")
print("请输入临近搜索要查询的第一个词项：", end='')
p1 = dict0[input()]
print("请输入临近搜索要查询的第二个词项：", end='')
p2 = dict0[input()]
print("临近搜索结果为：\n", PositionalIntersect(p1, p2, 1))

#!/usr/local/bin/python3

import os
import re
import codecs

def getFiles(dir, suffix): # 查找根目录，文件后缀 
    res = []
    for root, directory, files in os.walk(dir):  # =>当前根,根下目录,目录下的文件
        for filename in files:
            name, suf = os.path.splitext(filename) # =>文件名,文件后缀
            if suf == suffix:
                res.append(os.path.join(root, filename)) # =>吧一串字符串组合成路径
    return res

def isQuoteClass(classNames, files): # 类是否被引用过
    result = False
    for file in files:
        content = codecs.open(file, 'rb')
        for name in classNames:
            if re.search(r'.*$name.*', content, re.M):
                return True
        content.close()
    return result

projectPath = '/Users/caixiaodong/Documents/projects/ios-accelerator/TapBooster'

# 是否是文件夹
if os.path.isdir(projectPath) == False:
    print('path is no a dir')
    exit()

# 查找swift文件
allFiles = getFiles(projectPath, '.swift');

if allFiles.count == 0:
    print('cant find any file')
    exit()

uselessFiles = []

for file in allFiles:
    content = codecs.open(file, 'rb')
    line = content.readline
    classNames = []
    # for line in lines:
    #     if re.match(r'class .*: .* {', line, re.I):
    #         name = line.split(':')[0].split(' ')[1]
    #         classNames.append(name)
    #     elif re.match(r'class .* {', line, re.I):
    #         name = line.split(' ')[1].split(' ')[0]
    #         classNames.append(name)
    #     else:
    #         continue
    while line != '':
        if re.match(r'class .*: .* {', line, re.I):
            name = line.split(':')[0].split(' ')[1]
            classNames.append(name)
        elif re.match(r'class .* {', line, re.I):
            name = line.split(' ')[1].split(' ')[0]
            classNames.append(name)
        line = content.readline
        
    content.close()
    if classNames.count == 0:
        continue
    otherFiles = allFiles.remove(file)
    if isQuoteClass(classNames, otherFiles) == False:
        uselessFiles.append(file)

if uselessFiles.count == 0:
    print('there is no an useless file')
else:
    print('useless files:')
    print(uselessFiles)
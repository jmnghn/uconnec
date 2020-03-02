import os
import shutil

### [네이버] 음성듣고 문장 수정하기! (1832) ###
# FILE_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/네이버/음성듣고_문장_수정하기(1832)/labeled_data_1832_20190926.txt"
# EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/네이버/음성듣고_문장_수정하기(1832)/labeled_data_1832_20190926/"

### [네이버] 음성 텍스트 내용 수정하기 (1892) ###
FILE_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/네이버/음성_텍스트_내용_수정하기(1892)/labeled_data_1892_20190926.txt"
EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/네이버/음성_텍스트_내용_수정하기(1892)/labeled_data_1892_20190926/"

"""
check list

- 담당PM 이 준 맞춤법 검사를 마친 파일로 덮어쓰기를 잘했는지 !
"""

try:
    os.mkdir(EXT_PATH)
except FileExistsError:
    shutil.rmtree(EXT_PATH)
    os.mkdir(EXT_PATH)

f = open(FILE_PATH, 'r', encoding='UTF-8-sig')
lines = f.readlines()

idx = 0

for line in lines:
    line = line.split('\t')
    txt = open(EXT_PATH + line[0] + '.txt', 'w', encoding='utf-8')
    txt.write(line[1])
    txt.close()
    idx += 1

"""
[씨엔테크] 쌓여있는 박스 촬영_#2 (1759)

※ 특이사항
- [씨엔테크] 쌓여있는 박스 바운딩 (1760) 에 소스로 쓰임.
- NAS 에서 데이터 가져와야함.
"""

from crowdworks.commonUtil import *

import os
import shutil
import json
import uuid

TASK_ID = 2774
FILE_ID_LIST = []
FILE_NAME_LIST = []
EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/씨엔테크/쌓여있는_박스_촬영_#2(1759)/labeled_data_1759_"
SOURCE_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/씨엔테크/쌓여있는_박스_촬영_#2(1759)/" + str(TASK_ID) + "/"

import datetime

now = datetime.datetime.now()
year = str(now.year)
month = str(now.month).zfill(2)
day = str(now.day).zfill(2)

EXT_PATH = EXT_PATH + year + month + day + "/"

try:
    os.mkdir(EXT_PATH)
except FileExistsError:
    print("기존 추출 데이터 삭제하고 폴더 새로 만듦")
    shutil.rmtree(EXT_PATH)
    os.mkdir(EXT_PATH)

for dir in os.listdir(SOURCE_PATH):
    if dir != ".DS_Store":
        if os.path.isdir(SOURCE_PATH + dir):
            for file in os.listdir(SOURCE_PATH + dir):
                if file != ".DS_Store":
                    shutil.copy2(SOURCE_PATH + dir + "/" + file, SOURCE_PATH)

# QUERY_prj_data = "SELECT result_json FROM TB_PRJ_DATA WHERE prj_idx =" + str(
#     TASK_ID) + " AND prog_state_cd = 'ALL_FINISHED'"
QUERY_prj_data = "SELECT result_json FROM TB_PRJ_DATA WHERE prj_idx =" + str(TASK_ID) + " AND prog_state_cd = 'ALL_FINISHED' AND check_edate > '2019-09-16 11:55:48'" # TODO: 저 시간 이후로 추출해야 함. 이대로 쓰면 됨.
RESULT_prj_data = getDatabaseData(QUERY_prj_data, "", "", "")

# 1. 파일아이디 목록 만들기
for data in RESULT_prj_data:
    FILE_ID_LIST.append(json.loads(data[0])["fileId"])

FILE_ID_LIST = ','.join(FILE_ID_LIST)

QUERY_file_result = "SELECT store_file_name FROM CW_FILE_RESULT WHERE file_id in (" + FILE_ID_LIST + ")"
RESULT_file_result = getDatabaseData(QUERY_file_result, "", "", "")

print(QUERY_file_result)

# 2. 파일이름 목록 만들기
for file in RESULT_file_result:
    FILE_NAME_LIST.append(file[0])

# 3. 파일 복사
for file_name in FILE_NAME_LIST:
    try:
        shutil.copy2(SOURCE_PATH + file_name, EXT_PATH + str(uuid.uuid4()) + '.jpg')
        # shutil.copy2(SOURCE_PATH + file_name, EXT_PATH + file_name + '.jpg')
    except FileNotFoundError:
        raise FileNotFoundError

"""
[카이스트] 나무위키 맵핑 (프로젝트아이디: 1862, 태스크아이디: 3209, 3211)
"""
from crowdworks.commonUtil import *

import os
import json
import uuid
import shutil

EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/카이스트/나무위키맵핑(1862)/labeled_data_1862_"

task_id = "3211,3419"

QUERY = "SELECT * FROM TB_PRJ_DATA WHERE prj_idx in (" + task_id + ") AND prog_state_cd = 'ALL_FINISHED' AND problem_yn=0"
RESULT = getDatabaseData(QUERY, "", "", "")

# 추출 데이터 형식 맞춰서 폴더생성 (labeled_data_프로젝트아이디_추출일자)
import datetime

now = datetime.datetime.now()
year = str(now.year)
month = str(now.month).zfill(2)
day = str(now.day).zfill(2)
try:
    EXT_PATH = EXT_PATH + year + month + day + "/"
    os.mkdir(EXT_PATH)
except FileExistsError:
    print("이미 폴더 있음")
    shutil.rmtree(EXT_PATH)
    os.mkdir(EXT_PATH)
    pass
#

for data in RESULT:
    result_json = json.loads(data[14])
    print(result_json)

    file_name = str(uuid.uuid4())

    with open(EXT_PATH + file_name + '.json', 'w', encoding='UTF-8-sig') as outfile:
        json.dump(result_json, outfile, ensure_ascii=False, sort_keys=True, indent=4)

"""
[씨엔테크] 쌓여있는 박스 바운딩 (1760)
"""
from crowdworks.commonUtil import *

import os
import shutil
import json
import uuid

from PIL import Image  # 이미지 사이즈 가져오기용 라이브러리

TASK_ID = 2776

import datetime

now = datetime.datetime.now()
year = str(now.year)
month = str(now.month).zfill(2)
day = str(now.day).zfill(2)

EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/씨엔테크/쌓여있는_박스_바운딩(1760)/"
EXT_PATH_LABELED = EXT_PATH + "_labeled_data_1760_" + year + month + day + "/"

try:
    os.mkdir(EXT_PATH_LABELED)
except FileExistsError as e:
    print("##### 기존에 추출한 데이터를 모두 삭제하고 폴더 새로 만듦 #####")
    shutil.rmtree(EXT_PATH_LABELED)
    os.mkdir(EXT_PATH_LABELED)

# for task_id in task_id_list:

SOURCE_PATH = EXT_PATH + "source/"


# ※ 작업불가 있음 ※
# QUERY 1
QUERY_1 = "SELECT data_idx, work_user, result_json FROM TB_PRJ_DATA WHERE prj_idx=" + str(TASK_ID) + " AND prog_state_cd='ALL_FINISHED' AND problem_yn = 0"
QUERY_1_RESULT = getDatabaseData(QUERY_1, "", "", "")

for q_1_data in QUERY_1_RESULT:
    # json 파일 만들 때 사용할 format dict
    json_data_format = {
        "image": {
            "width": 0,
            "height": 0
        },
        "boxes": []
    }
    data_idx = q_1_data[0]
    result_json = q_1_data[2]

    QUERY_2 = "SELECT CFU.store_file_name, CS.uuid_str FROM TB_PRJ_DATA AS TPD LEFT JOIN TB_MEMBER AS TM ON TM.member_id = TPD.work_user LEFT JOIN TB_TMPL_IMG_LABEL_DATA AS TLD ON TPD.data_idx  = TLD.data_idx LEFT JOIN CW_SOURCE AS CS ON CS.source_id = TLD.src_idx LEFT JOIN CW_FILE_UNPACKED AS CFU ON CFU.file_id = CS.file_id WHERE TPD.prj_idx IN (" + str(TASK_ID) + ") AND TPD.data_idx=" + str(data_idx)
    file_name = getDatabaseData(QUERY_2, "", "", "")

    _uuid = file_name[0][1]
    # 가져올 이미지 파일 경로 (원본)
    SOURCE_IMAGE_PATH = SOURCE_PATH + file_name[0][0]

    # 복사할 이미지 파일 경로
    EXT_PATH_UUID = EXT_PATH_LABELED + _uuid + "/"

    # 3. 추출 파일 저장할 디렉토리 생성 - 개별
    EXT_PATH_TASK_UUID = EXT_PATH_LABELED + _uuid
    try:
        if not (os.path.isdir(EXT_PATH_TASK_UUID)):
            os.makedirs(os.path.join(EXT_PATH_TASK_UUID))
            # print(EXT_PATH_TASK_UUID + " 폴더 생성 성공")
    except OSError as e:
        if e.errno != e.errno.EEXIST:
            # print(EXT_PATH_TASK_UUID + " 폴더 생성 실패")
            raise
    # / 3. 추출 파일 저장할 디렉토리 생성 - 개별

    # 이미지 복사
    # 이미지 파일 이름도 uuid.jpg
    shutil.copy2(SOURCE_IMAGE_PATH, EXT_PATH_UUID + "/" + _uuid + '.jpg')

    # PIL 라이브러리에 Image 사용해 사이즈 가져오기
    image = Image.open(SOURCE_IMAGE_PATH)
    width, height = image.size

    # 추출 json - image - width/height 채우기
    json_data_format["image"]["width"] = width
    json_data_format["image"]["height"] = height

    data_dict = json.loads(result_json)

    for data in data_dict['data']:
        # json_data_format['labeling'] 에 넣어줄 item format
        dots = {
            "data_id": 0,
            "dots": {
                "x": 0,  # 좌표값 x
                "y": 0,  # 좌표값 y
                "width": 0,  # 바운딩박스 가로 폭
                "height": 0  # 바운딩박스 세로 높이
            }
        }

        dots['data_id'] = data['id']
        dots['dots']['x'] = min(data['dots'], key=lambda x: x['x'])['x']
        dots['dots']['y'] = min(data['dots'], key=lambda x: x['y'])['y']
        dots['dots']['width'] = abs(data['dots'][0]['x'] - data['dots'][1]['x'])
        dots['dots']['height'] = abs(data['dots'][1]['y'] - data['dots'][2]['y'])

        json_data_format["boxes"].append(dots)

    # 4. JSON 생성
    with open(EXT_PATH_UUID + "/" + _uuid + '.json', 'w', encoding='UTF-8-sig') as outfile:
        json.dump(json_data_format, outfile, ensure_ascii=False, sort_keys=True, indent=4)
    # / 4. JSON 생성

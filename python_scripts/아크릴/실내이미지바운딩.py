"""
[아크릴] 실내 이미지 바운딩 (1636)
"""
from crowdworks.commonUtil import *

import os
import shutil
import json
import uuid

from PIL import Image  # 이미지 사이즈 가져오기용 라이브러리


# task_id -> '장소명'
def switch(x):
    return {
        2035: "01_발코니_베란다",
        2036: "02_욕실",
        2037: "03_침실",
        2038: "04_옷방",
        2039: "05_식사실",
        2040: "06_현관",
        2041: "07_아이방",
        2042: "08_주방",
        2043: "09_거실",
        2044: "10_서재_공부방",
        2045: "11_다용도실"
    }.get(x, False)


# 이미지 수집 task_id -> 바운딩 박스 task_id 변환
def switchTaskId(x):
    return {
        2010: 2035,
        2011: 2036,
        2012: 2037,
        2013: 2038,
        2014: 2039,
        2015: 2040,
        2016: 2041,
        2017: 2042,
        2018: 2043,
        2019: 2044,
        2020: 2045
    }.get(x, False)


task_id_list = [2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020]
# [2035, 2036, 2037, 2038, 2039, 2040, 2041, 2042, 2043, 2044, 2045]

import datetime

now = datetime.datetime.now()
year = str(now.year)
month = str(now.month).zfill(2)
day = str(now.day).zfill(2)

EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/아크릴/실내이미지바운딩(1636)/"
EXT_PATH_LABELED = EXT_PATH + "labeled_data_1636_" + year + month + day + "/"

try:
    os.mkdir(EXT_PATH_LABELED)
except FileExistsError as e:
    print("##### 기존에 추출한 데이터를 모두 삭제하고 폴더 새로 만듦 #####")
    shutil.rmtree(EXT_PATH_LABELED)
    os.mkdir(EXT_PATH_LABELED)

for task_id in task_id_list:

    # SOURCE_PATH = EXT_PATH + str(task_id) + "/"
    # SOURCE_PATH = "/Volumes/MHDATA/DATA_EXT/아크릴/실내이미지바운딩(1636)/" + str(task_id) + "/"
    SOURCE_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/아크릴/실내이미지바운딩(1636)/" + str(task_id) + "/"

    # 1. 추출 파일 저장할 디렉토리 생성 - 최상위
    EXT_PATH_TASK = EXT_PATH_LABELED + switch(switchTaskId(task_id)) + "/"
    try:
        if not (os.path.isdir(EXT_PATH_TASK)):
            os.makedirs(os.path.join(EXT_PATH_TASK))
            # print(EXT_PATH_TASK + " 폴더 생성 성공")
    except OSError as e:
        if e.errno != e.errno.EEXIST:
            # print(EXT_PATH_TASK + " 폴더 생성 실패")
            raise
    # / 1. 추출 파일 저장할 디렉토리 생성 - 최상위

    # 2. 수집한 이미지 파일들 한 경로 위로 (/) 복사
    for dir_name in os.listdir(SOURCE_PATH):
        try:

            for img_files in os.walk(SOURCE_PATH + dir_name):
                for img_file in img_files[2]:
                    shutil.copy2(SOURCE_PATH + dir_name + "/" + img_file, SOURCE_PATH)

        except ValueError:  # 디렉토리명 외 파일이름일 경우 예외처리
            pass
    # / 2. 수집한 이미지 파일들 한 경로 위로 (/) 복사

    # QUERY 1
    QUERY_1 = "SELECT data_idx, work_user, result_json FROM TB_PRJ_DATA WHERE prj_idx=" + str(switchTaskId(
        task_id)) + " AND prog_state_cd='ALL_FINISHED'"
    QUERY_1_RESULT = getDatabaseData(QUERY_1, "", "", "")

    for q_1_data in QUERY_1_RESULT:
        # json 파일 만들 때 사용할 format dict
        json_data_format = {
            "class": "",
            "image": {
                "width": 0,
                "height": 0
            },
            "labeling": []
        }
        data_idx = q_1_data[0]
        result_json = q_1_data[2]

        # 추출 json - class(장소) 채우기
        json_data_format['class'] = switch(switchTaskId(task_id)).split('_')[1]

        # QUERY 2
        # QUERY_2 = "select U.store_file_name, uuid_str from  TB_PRJ_DATA     D left join TB_MEMBER M on M.member_id = D.work_user left join TB_TMPL_IMG_LABEL_DATA L on D.data_idx  = L.data_idx left join CW_SOURCE S on S.source_id = L.src_idx left join CW_FILE_UNPACKED U  on U.file_id = S.file_id where D.prj_idx in (" + str(
        #     switchTaskId(task_id)) + ") AND D.data_idx=" + str(data_idx)
        # file_name = getDatabaseData(QUERY_2, "", "", "")

        QUERY_2 = "SELECT CFU.store_file_name, CS.uuid_str FROM TB_PRJ_DATA AS TPD LEFT JOIN TB_MEMBER AS TM ON TM.member_id = TPD.work_user LEFT JOIN TB_TMPL_IMG_LABEL_DATA AS TLD ON TPD.data_idx  = TLD.data_idx LEFT JOIN CW_SOURCE AS CS ON CS.source_id = TLD.src_idx LEFT JOIN CW_FILE_UNPACKED AS CFU ON CFU.file_id = CS.file_id WHERE TPD.prj_idx IN (" + str(
            switchTaskId(task_id)) + ") AND TPD.data_idx=" + str(data_idx)
        file_name = getDatabaseData(QUERY_2, "", "", "")

        _uuid = file_name[0][1]
        # 가져올 이미지 파일 경로 (원본)
        SOURCE_IMAGE_PATH = SOURCE_PATH + file_name[0][0]

        # 복사할 이미지 파일 경로
        EXT_PATH_UUID = EXT_PATH_TASK + _uuid + "/"

        # 3. 추출 파일 저장할 디렉토리 생성 - 개별
        EXT_PATH_TASK_UUID = EXT_PATH_TASK + _uuid
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
            labeling_item = {
                "label": "",  # 사물명
                "box": {
                    "x": 0,  # 좌표값 x
                    "y": 0,  # 좌표값 y
                    "width": 0,  # 바운딩박스 가로 폭
                    "height": 0  # 바운딩박스 세로 높이
                }
            }

            labeling_item['label'] = data['data'][0]['value']
            labeling_item['box']['x'] = min(data['dots'], key=lambda x: x['x'])['x']
            labeling_item['box']['y'] = min(data['dots'], key=lambda x: x['y'])['y']
            labeling_item['box']['width'] = abs(data['dots'][0]['x'] - data['dots'][1]['x'])
            labeling_item['box']['height'] = abs(data['dots'][1]['y'] - data['dots'][2]['y'])

            json_data_format["labeling"].append(labeling_item)

        # 4. JSON 생성
        with open(EXT_PATH_UUID + "/" + _uuid + '.json', 'w', encoding='UTF-8-sig') as outfile:
            json.dump(json_data_format, outfile, ensure_ascii=False, sort_keys=True, indent=4)
        # / 4. JSON 생성

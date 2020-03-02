"""
[아크릴] 사물 촬영 및 바운딩 (1587)
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
        1933: "01_발코니_베란다",
        1942: "02_욕실",
        1944: "03_침실",
        1945: "04_옷방",
        1946: "05_식사실",
        1947: "06_현관",
        1948: "07_아이방",
        1949: "08_주방",
        1950: "09_거실",
        1951: "10_서재_공부방",
        1952: "11_다용도실",
        1953: "12_실내"
    }.get(x, False)


import datetime

now = datetime.datetime.now()
year = str(now.year)
month = str(now.month).zfill(2)
day = str(now.day).zfill(2)

EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/아크릴/사물촬영및바운딩(1587)/"
EXT_PATH_LABELED = EXT_PATH + "labeled_data_1587_" + year + month + day + "/"

try:
    os.mkdir(EXT_PATH_LABELED)
except FileExistsError as e:
    print("##### 기존에 추출한 데이터를 모두 삭제하고 폴더 새로 만듦 #####")
    shutil.rmtree(EXT_PATH_LABELED)
    os.mkdir(EXT_PATH_LABELED)

task_id_list = [1933, 1942, 1944, 1945, 1946, 1947, 1948, 1949, 1950, 1951, 1952, 1953]

for task_id in task_id_list:
    print(switch(task_id) + " 추출시작")

    # SOURCE_PATH = EXT_PATH + str(task_id) + "/"
    # SOURCE_PATH = "/Volumes/MHDATA/DATA_EXT/아크릴/사물촬영및바운딩(1587)/" + str(task_id) + "/"
    SOURCE_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/아크릴/사물촬영및바운딩(1587)/" + str(task_id) + "/"

    # 1. 추출 파일 저장할 디렉토리 생성 - 최상위
    EXT_PATH_TASK = EXT_PATH_LABELED + switch(task_id) + "/"
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
    QUERY_1 = "SELECT data_idx, work_user, result_json FROM TB_PRJ_DATA WHERE prj_idx=" + str(
        task_id) + " AND prog_state_cd='ALL_FINISHED'"
    # print("### QUERY_1 ### \n", QUERY_1)
    QUERY_1_RESULT = getDatabaseData(QUERY_1, "prd", "mhjeong", "cworks@34")

    # QUERY 2
    QUERY_2 = "SELECT file_id, store_file_name FROM CW_FILE_RESULT WHERE task_id=" + str(task_id)
    # print("### QUERY_2 ### \n", QUERY_2)
    QUERY_2_RESULT = getDatabaseData(QUERY_2, "prd", "mhjeong", "cworks@34")

    FILE_NAME_DICT = dict(QUERY_2_RESULT)

    for data in QUERY_1_RESULT:
        # print(data)
        # json 파일 만들 때 사용할 format dict
        json_data_format = {
            "class": "",
            "image": {
                "width": 0,
                "height": 0
            },
            "labeling": []
        }
        data_idx = data[0]
        result_json = json.loads(data[2])

        # 추출 json - class(장소) 채우기
        json_data_format['class'] = switch(task_id).split('_')[1]

        _uuid = str(uuid.uuid4())

        if int(result_json["fileId"]) == 607717:
            print("##### KeyError ##### _uuid", _uuid, '\n')
            print("##### KeyError ##### result_json", result_json, '\n')
            print("##### KeyError ##### data", data)

        # 가져올 이미지 파일 경로 (원본)
        try:
            SOURCE_IMAGE_PATH = SOURCE_PATH + FILE_NAME_DICT[int(result_json["fileId"])]
        except KeyError:
            print("##### KeyError ##### _uuid", _uuid, '\n')
            print("##### KeyError ##### result_json", result_json, '\n')
            print("##### KeyError ##### data", data)

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
        # 이미지 파일 이름도 _uuid.jpg
        shutil.copy2(SOURCE_IMAGE_PATH, EXT_PATH_UUID + _uuid + ".jpg")

        # PIL 라이브러리에 Image 사용해 사이즈 가져오기
        image = Image.open(SOURCE_IMAGE_PATH)
        width, height = image.size

        # 추출 json - image - width/height 채우기
        json_data_format["image"]["width"] = width
        json_data_format["image"]["height"] = height

        data_dict = result_json

        for data in data_dict['label-list']:
            labeling_item = {
                "label": "",  # 사물명
                "box": {
                    "x": 0,  # 좌표값 x
                    "y": 0,  # 좌표값 y
                    "width": 0,  # 바운딩박스 가로 폭
                    "height": 0  # 바운딩박스 세로 높이
                }
            }

            if data['label'] == "놀이배트":
                labeling_item['label'] = "놀이매트"
                print("_uuid: ", _uuid, '\n')
                print('FILE_NAME_DICT[int(result_json["fileId"])]', FILE_NAME_DICT[int(result_json["fileId"])])
            else:
                labeling_item['label'] = data['label']
            labeling_item['box']['x'] = data['box']['x']
            labeling_item['box']['y'] = data['box']['y']
            labeling_item['box']['width'] = data['box']['width']
            labeling_item['box']['height'] = data['box']['height']

            json_data_format["labeling"].append(labeling_item)

            # print("### json ###", copy_to_path + "/" + _uuid + '.json')

        # 4. JSON 생성
        with open(EXT_PATH_UUID + _uuid + '.json', 'w', encoding='UTF-8-sig') as outfile:
            json.dump(json_data_format, outfile, ensure_ascii=False, sort_keys=True, indent=4)
        # / 4. JSON 생성

    print(switch(task_id) + " 추출완료")
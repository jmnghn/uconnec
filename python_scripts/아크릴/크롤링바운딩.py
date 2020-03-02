"""
[아크릴] 크롤링한 이미지 바운딩

개발 서버 데이터 추출확인
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
        1715: "01_베란다",
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


task_id_list = [1715]

import datetime

now = datetime.datetime.now()
year = str(now.year)
month = str(now.month).zfill(2)
day = str(now.day).zfill(2)

EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/아크릴/크롤링바운딩(1893)/labeled_data_1893_" + year + month + day + "/"
try:
    os.mkdir(EXT_PATH)
except:
    print("##### 기존에 추출한 데이터를 모두 삭제하고 폴더 새로 만듦 #####")
    shutil.rmtree(EXT_PATH)
    os.mkdir(EXT_PATH)

for task_id in task_id_list:

    SOURCE_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/아크릴/크롤링바운딩(1893)/소스/" + str(task_id) + "/"

    # 1. 장소별로 추출 폴더 생성
    EXT_PATH_TASK = EXT_PATH + switch(task_id) + "/"
    os.mkdir(EXT_PATH_TASK)
    # / 1. 장소별로 추출 폴더 생성

    # QUERY_1 1
    QUERY_1 = "select data_idx, work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(
        task_id) + " and prog_state_cd='WORK_END' and problem_yn = 0"
    # QUERY_1 = "SELECT data_idx, work_user, result_json FROM TB_PRJ_DATA WHERE prj_idx=" + str(task_id) + " AND prog_state_cd='ALL_FINISHED' AND problem_yn = 0"
    # QUERY_1_RESULT = getDatabaseData(QUERY_1, "prd", "mhjeong", "cworks@34")
    QUERY_1_RESULT = getDatabaseData(QUERY_1, "dev", "cwdbuser", "ckadlselql#3")

    for data in QUERY_1_RESULT:
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
        result_json = data[2]

        # 추출 json - class(장소) 채우기
        json_data_format['class'] = switch(task_id).split('_')[1]

        # QUERY_2
        QUERY_2 = "SELECT CFU.store_file_name, CS.uuid_str FROM TB_PRJ_DATA AS TPD LEFT JOIN TB_MEMBER AS TM ON TM.member_id = TPD.work_user LEFT JOIN TB_TMPL_IMG_LABEL_DATA AS TLD ON TPD.data_idx  = TLD.data_idx LEFT JOIN CW_SOURCE AS CS ON CS.source_id = TLD.src_idx LEFT JOIN CW_FILE_UNPACKED AS CFU ON CFU.file_id = CS.file_id WHERE TPD.prj_idx IN (" + str(
            task_id) + ") AND TPD.data_idx=" + str(data_idx)
        # file_name = getDatabaseData(QUERY_2, "prd", "mhjeong", "cworks@34")
        QUERY_2_RESULT = getDatabaseData(QUERY_2, "dev", "cwdbuser", "ckadlselql#3")

        store_file_name = str(QUERY_2_RESULT[0][0])
        uuid = str(QUERY_2_RESULT[0][1])

        SOURCE_IMAGE_FILE = SOURCE_PATH + store_file_name
        EXT_PATH_UUID = EXT_PATH_TASK + "/" + uuid

        # 3. 추출 파일 저장할 디렉토리 생성 - 개별
        EXT_PATH_TASK_uuid = EXT_PATH_TASK + uuid
        try:
            if not (os.path.isdir(EXT_PATH_TASK_uuid)):
                os.makedirs(os.path.join(EXT_PATH_TASK_uuid))
                print(EXT_PATH_TASK_uuid + " 폴더 생성 성공")
        except OSError as e:
            if e.errno != e.errno.EEXIST:
                print(EXT_PATH_TASK_uuid + " 폴더 생성 실패")
                raise
        # / 3. 추출 파일 저장할 디렉토리 생성 - 개별

        """
        크롤링한 이미지 소스 분류가 구조가 어떻게 될지 모르므로 결과 보고 로컬에서도 맞춰야 함.
        # 소스 이미지 복사 - 이미지 파일 이름도 uuid.jpg
        shutil.copy2(SOURCE_IMAGE_FILE, EXT_PATH_UUID + "/" + uuid + '.jpg')

        # PIL 라이브러리에 Image 사용해 사이즈 가져오기
        image = Image.open(SOURCE_IMAGE_FILE)
        width, height = image.size

        # 추출 json - image - width/height 채우기
        json_data_format["image"]["width"] = width
        json_data_format["image"]["height"] = height
        """

        data_dict = json.loads(result_json)

        print(data_dict)

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

            if data['data'][0]['value'] != "none":
                labeling_item['label'] = data['data'][0]['value']
            if data['data'][1]['value'] != "none":
                labeling_item['label'] = data['data'][1]['value']
            if data['data'][2]['value'] != "none":
                labeling_item['label'] = data['data'][2]['value']

            labeling_item['box']['x'] = min(data['dots'], key=lambda x: x['x'])['x']
            labeling_item['box']['y'] = min(data['dots'], key=lambda x: x['y'])['y']
            labeling_item['box']['width'] = abs(data['dots'][0]['x'] - data['dots'][1]['x'])
            labeling_item['box']['height'] = abs(data['dots'][1]['y'] - data['dots'][2]['y'])

            json_data_format["labeling"].append(labeling_item)

        # 4. JSON 생성
        with open(EXT_PATH_UUID + "/" + uuid + '.json', 'w', encoding='UTF-8-sig') as outfile:
            json.dump(json_data_format, outfile, ensure_ascii=False)
        # / 4. JSON 생성

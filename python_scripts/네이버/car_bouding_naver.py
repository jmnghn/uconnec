from crowdworks.commonUtil import *

import os
import shutil
import json
import uuid

from PIL import Image  # 이미지 사이즈 가져오기용 라이브러리

task_id = 2270

origin_path = "/Users/myeonghyeonjeong/Desktop/CarBoudingNaver/"
output_path = "/Users/myeonghyeonjeong/Desktop/CarBoudingNaver/output/"
source_path = "/Users/myeonghyeonjeong/Desktop/CarBoudingNaver/source/"

# 1. 추출 파일 저장할 디렉토리 생성 - 최상위
try:
    if not (os.path.isdir(output_path)):
        os.makedirs(os.path.join(output_path))
        print(output_path + " 폴더 생성 성공")
except OSError as e:
    if e.errno != e.errno.EEXIST:
        print(output_path + " 폴더 생성 실패")
        raise
# / 1. 추출 파일 저장할 디렉토리 생성 - 최상위

# QUERY 1
# sql_result_json = "select data_idx, work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(task_id)
sql_result_json = "select data_idx, work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(task_id) + " and prog_state_cd='ALL_FINISHED'"
# print("### sql_result_json ### \n", sql_result_json)
prj_data_list = getDatabaseData(sql_result_json, "prd", "mhjeong", "cworks@34")

idx = 0

for prj_data in prj_data_list:
    # json 파일 만들 때 사용할 format dict
    json_data_format = {
        "image": {
            "width": 0,
            "height": 0
        },
        "labeling": []
    }
    data_idx = prj_data[0]
    result_json = prj_data[2]

    # 추출 json - class(장소) 채우기
    # json_data_format['class'] = switch(switchTaskId(task_id)).split('_')[1]

    # QUERY 2
    sql_file_name = "select U.store_file_name, uuid_str from  TB_PRJ_DATA     D left join TB_MEMBER M on M.member_id = D.work_user left join TB_TMPL_IMG_LABEL_DATA L on D.data_idx  = L.data_idx left join CW_SOURCE S on S.source_id = L.src_idx left join CW_FILE_UNPACKED U  on U.file_id = S.file_id where D.prj_idx in (" + str(
        task_id) + ") AND D.data_idx=" + str(data_idx)
    # print("### sql_file_name ### \n", sql_file_name)
    file_name_result = getDatabaseData(sql_file_name, "prd", "mhjeong", "cworks@34")
    file_name = file_name_result[0][0]

    # uuid_name = file_name[0][1]
    # 가져올 이미지 파일 경로 (원본)
    origin_image_path = source_path + file_name
    # 복사할 이미지 파일 경로
    copy_to_path = output_path + "/" + file_name

    # 3. 추출 파일 저장할 디렉토리 생성 - 개별
    if ("현대_KONA 1" in file_name) or ("현대_투싼1" in file_name):
        output_path_name = output_path + file_name.split('.')[0] + file_name.split('.')[1] + "/"
    else:
        output_path_name = output_path + file_name.split('.')[0] + "/"

    try:
        if not (os.path.isdir(output_path_name)):
            os.makedirs(os.path.join(output_path_name))
            print(output_path_name + " 폴더 생성 성공")
    except OSError as e:
        if e.errno != e.errno.EEXIST:
            print(output_path_name + " 폴더 생성 실패, file_name: " + file_name)
            raise
    # / 3. 추출 파일 저장할 디렉토리 생성 - 개별

    # 이미지 복사
    # 이미지 파일 이름도 uuid.jpg
    shutil.copy2(origin_image_path, output_path_name + file_name)

    # PIL 라이브러리에 Image 사용해 사이즈 가져오기
    image = Image.open(origin_image_path)
    width, height = image.size

    # 추출 json - image - width/height 채우기
    json_data_format["image"]["width"] = width
    json_data_format["image"]["height"] = height

    if result_json is not None:
        data_dict = json.loads(result_json)

        for data in data_dict['data']:
            # json_data_format['labeling'] 에 넣어줄 item format
            labeling_item = {
                "box": {
                    "x": 0,  # 좌표값 x
                    "y": 0,  # 좌표값 y
                    "width": 0,  # 바운딩박스 가로 폭
                    "height": 0  # 바운딩박스 세로 높이
                }
            }

            labeling_item['box']['x'] = min(data['dots'], key=lambda x: x['x'])['x']
            labeling_item['box']['y'] = min(data['dots'], key=lambda x: x['y'])['y']
            labeling_item['box']['width'] = abs(data['dots'][0]['x'] - data['dots'][1]['x'])
            labeling_item['box']['height'] = abs(data['dots'][1]['y'] - data['dots'][2]['y'])

            json_data_format["labeling"].append(labeling_item)

        # 4. JSON 생성
        with open(output_path_name + file_name.split('.')[0] + '.json', 'w', encoding='UTF-8-sig') as outfile:
            json.dump(json_data_format, outfile, ensure_ascii=False)
        # / 4. JSON 생성
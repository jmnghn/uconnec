from crowdworks.commonUtil import *

import os
import shutil
import json
import uuid

# SELECT * FROM
# TB_PRJ_DATA
# WHERE
# prj_idx in (
# 2272, 2273, 2274, 2275, 2276, 2277, 2278, 2279, 2280, 2281, 2282, 2283, 2284, 2285, 2286, 2287, 2288, 2289, 2290, 2291, 2292, 2293, 2294, 2295, 2296, 2297, 2298) and prog_state_cd = "ALL_FINISHED";

# 1차 - 2019-07-11 11:55:01 까지
# task_id_list = [2272, 2273, 2274, 2275, 2276, 2277, 2278, 2279, 2280, 2281, 2282, 2283, 2284, 2285, 2286, 2287, 2288, 2289, 2290, 2291, 2292, 2293, 2294, 2295, 2296, 2297, 2298]
# # 2차 - 2019-07-11 11:54:37 까지
# task_id_list = [2356,2357,2358,2359,2360,2361,2362,2363,2364,2365]
# 3차 - 2019-07-11 11:59:46 까지
task_id_list = [2372,2373,2374,2375,2376,2377,2378,2379,2380,2381]

startDate = 190710
endDate = 190712

notFoundCounter = 0

for task_id in task_id_list:
    origin_path = "/Users/myeonghyeonjeong/Desktop/NaverFoodBouding/" + str(task_id) + "/"

    # 1. 소스로 사용할 이미지, 복사할 디렉토리 생성
    # output_path 형식: taskid_startDate-edDate (ex. 2010_190610-190614)
    output_path = "/Users/myeonghyeonjeong/Desktop/NaverFoodBouding/source/" + str(startDate) + "-" + str(endDate-1)
    try:
        if not (os.path.isdir(output_path)):
            os.makedirs(os.path.join(output_path))
            print(output_path + " 폴더 생성 성공")
    except OSError as e:
        if e.errno != e.errno.EEXIST:
            print(output_path + " 폴더 생성 실패")
            raise
    # / 1. 소스로 사용할 이미지, 복사할 디렉토리 생성

    # 2. 수집한 이미지 파일들 한 경로 위로 (/) 복사
    try:
        for dir_name in os.listdir(origin_path):
            try:

                for img_files in os.walk(origin_path + dir_name):
                    for img_file in img_files[2]:
                        shutil.copy2(origin_path + dir_name + "/" + img_file, origin_path)

            except ValueError:  # 디렉토리명 외 파일이름일 경우 예외처리
                pass
    except FileNotFoundError:
        print('파일을 찾을 수 없습니다. task_id: ', task_id)
    # / 2. 수집한 이미지 파일들 한 경로 위로 (/) 복사

    # # 1차
    # sql_result_json = "select work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(
    #     task_id) + " and prog_state_cd='ALL_FINISHED' and '2019-07-10 17:29:58' < check_edate"
    # 2차
    # sql_result_json = "select work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(
    #     task_id) + " and prog_state_cd='ALL_FINISHED'  and '2019-07-10 17:31:15' < check_edate"
    # print("### sql_result_json ### \n", sql_result_json)
    # 3차
    sql_result_json = "select work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(
        task_id) + " and prog_state_cd='ALL_FINISHED' and '2019-07-11 11:59:46' < check_edate"
    # print("### sql_result_json ### \n", sql_result_json)

    prj_data_list = getDatabaseData(sql_result_json, "prd", "mhjeong", "cworks@34")

    for prj_data in prj_data_list:

        reg_user = str(prj_data[0])

        # CW_FILE_RESULT 에서 { 파일아이디: 파일이름 } 목록 가져오기 (ex.{657183: '1560304053372-247.jpg'})
        sql_get_file_name_list = "SELECT file_id, store_file_name from CW_FILE_RESULT where task_id=" + str(
            task_id) + " and reg_user=" + reg_user
        print("### sql_get_file_name_list ### \n", sql_get_file_name_list)
        # Dict 로 변환
        all_file_name_dict = dict((file_id, file_name) for file_id, file_name in getDatabaseData(sql_get_file_name_list, "prd", "mhjeong", "cworks@34"))

        # 복사 할 경로
        try:
            copy_from_path = origin_path + all_file_name_dict[int(json.loads(prj_data[1])['fileId'])]
            shutil.copy2(copy_from_path, output_path + "/" + all_file_name_dict[int(json.loads(prj_data[1])['fileId'])])
        except FileNotFoundError:
            notFoundCounter = notFoundCounter + 1
            print("file name: ", all_file_name_dict[int(json.loads(prj_data[1])['fileId'])], '\n')
            print('FileNotFoundError', prj_data)

print(notFoundCounter)
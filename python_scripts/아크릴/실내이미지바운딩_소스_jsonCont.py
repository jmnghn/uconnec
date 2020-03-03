from crowdworks.commonUtil import *

import os
import shutil
import json



# 수집 -> 바운딩, 장소매칭되도록 task_id 변경
def switch(x):
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
startDate = 190725
endDate = 190903

for task_id in task_id_list:
    origin_path = "/Users/myeonghyeonjeong/Desktop/AcrylImgBoundingSource/" + str(task_id) + "/"

    # 1. 소스로 사용할 이미지, 복사할 디렉토리 생성
    # output_path 형식: taskid_startDate-edDate (ex. 2010_190610-190614)
    output_path = "/Users/myeonghyeonjeong/Desktop/AcrylImgBoundingSource/source/" + str(switch(task_id)) + "_" + str(startDate) + "-" + str(endDate-1)
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
    for dir_name in os.listdir(origin_path):
        try:

            for img_files in os.walk(origin_path + dir_name):
                for img_file in img_files[2]:
                    shutil.copy2(origin_path + dir_name + "/" + img_file, origin_path)

        except ValueError:  # 디렉토리명 외 파일이름일 경우 예외처리
            pass
    # / 2. 수집한 이미지 파일들 한 경로 위로 (/) 복사

    sql_result_json = "select work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(task_id) + " and prog_state_cd='ALL_FINISHED' and '2019-07-25' < check_edate and check_edate < '2019-09-03'"
    # print("### sql_result_json ### \n", sql_result_json)
    prj_data_list = getDatabaseData(sql_result_json, "", "", "")

    for prj_data in prj_data_list:

        reg_user = str(prj_data[0])

        # CW_FILE_RESULT 에서 { 파일아이디: 파일이름 } 목록 가져오기 (ex.{657183: '1560304053372-247.jpg'})
        sql_get_file_name_list = "SELECT file_id, store_file_name from CW_FILE_RESULT where task_id=" + str(
            task_id) + " and reg_user=" + reg_user
        # print("### sql_get_file_name_list ### \n", sql_get_file_name_list)
        # Dict 로 변환
        all_file_name_dict = dict((file_id, file_name) for file_id, file_name in getDatabaseData(sql_get_file_name_list, "", "", ""))

        # 복사 할 경로
        copy_from_path = origin_path + all_file_name_dict[int(json.loads(prj_data[1])['fileId'])]
        shutil.copy2(copy_from_path, output_path + "/" + all_file_name_dict[int(json.loads(prj_data[1])['fileId'])])


# jsonCont 생성용 QUERY
#
# SELECT prj_idx, result_json, store_file_name
# FROM TB_PRJ_DATA PD
# INNER JOIN CW_FILE_RESULT FR ON PD.prj_idx = FR.task_id AND PD.result_json ->> "$.fileId" = FR.file_id
# WHERE prj_idx in (2010, 2011, 2012, 2013, 2014, 2015, 2016, 2017, 2018, 2019, 2020) and PD.prog_state_cd='ALL_FINISHED' and '2019-07-25' < check_edate and check_edate < '2019-09-03'"
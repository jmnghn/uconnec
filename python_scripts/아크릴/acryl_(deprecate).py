from crowdworks.commonUtil import *

import os
import shutil
import json
import uuid


# 폴더명에 사용할 테스크 이름 목록
def switch(x):
    return {
        1933: "발코니_베란다/",
        1942: "욕실/",
        1944: "침실/",
        1945: "옷방/",
        1946: "식사실/",
        1947: "현관/",
        1948: "아이방/",
        1949: "주방/",
        1950: "거실/",
        1951: "서재_공부방/",
        1952: "다용도실/"
    }.get(x, False)


task_id_list = [1933, 1942, 1944, 1945, 1946, 1947, 1948, 1949, 1950, 1951, 1952]
result_text_list = []

for id in task_id_list:

    abs_path = "/Users/myeonghyeonjeong/Desktop/"
    project_name = "Acryl"
    task_id = id
    target_dir = abs_path + project_name + "/" + str(task_id)

    file_copy_state_flag = False # 날짜검사용 Flag

    # 날짜별로 분류 된 파일들 상위 경로로 COPY
    for dir_name in os.listdir(target_dir):
        if len(dir_name) > 6:
            pass
        #TODO: 날짜 설정 하려면 쿼리도 수정되야함...
        elif int(dir_name) < 190700:
            # print(int(dir_name))
            for i in os.walk(target_dir + "/" + dir_name):
                for j in i[2]:
                    # print(j)
                    shutil.copy2(target_dir + "/" + dir_name + "/" + j, target_dir)
                    file_copy_state_flag = True

    if (file_copy_state_flag):
        # TB_PRJ_DATA 테이블에서 해당 task 의 prog_state_cd 가 ALL_FINISHED 인 작업의 user_id 와 result_json 가져오기
        sql_result_json = "select work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(
            task_id) + " and prog_state_cd='ALL_FINISHED'"
        all_finished_prj_data_list = getDatabaseData(sql_result_json, "", "", "")

        task_file_counter = 0

        for all_finished_prj_data in all_finished_prj_data_list:

            task_file_counter = task_file_counter + 1

            # sql_get_user_id = "select login_id from TB_MEMBER where member_id=" + str(all_finished_prj_data[0])
            # user_id = getDatabaseData(sql_get_user_id, "", "", "")[0][0]

            # 결과 추출 복사할 파일 경로
            new_dir = "/Users/myeonghyeonjeong/Desktop/" + project_name + "/output/" + switch(task_id) + str(
                uuid.uuid4())

            try:
                if os.path.exists(new_dir):
                    print('이미 폴더가 있습니다.')
                else:
                    os.makedirs(os.path.join(new_dir))
            except FileNotFoundError:
                print('파일을 찾을 수 없습니다.')

            # CW_FILE_RESULT 테이블에서 file_id 와 저장된 파일 이름 목록 가져오기
            sql_get_file_name_list = "SELECT file_id, store_file_name from CW_FILE_RESULT where task_id=" + str(
                task_id) + " and reg_user=" + str(all_finished_prj_data[0]) + " and reg_date > '2019-05-01'"

            # dict 로 만들기...
            all_file_name_dict = dict((file_id, file_name) for file_id, file_name in
                                      getDatabaseData(sql_get_file_name_list, "", "", ""))

            if not str(json.loads(all_finished_prj_data[1])['fileId']) == "607717":
            #     if not str(json.loads(all_finished_prj_data[1])['fileId']) == "644815":
                # 복사해올 파일경로 생성
                origin_dir = target_dir + "/" + all_file_name_dict[int(json.loads(all_finished_prj_data[1])['fileId'])]
                # 이미지 파일 복사 target_dir >>> new_dir
                shutil.copy2(origin_dir, new_dir + "/" + json.loads(all_finished_prj_data[1])['fileId'] + '.jpg')

            # JSON 생성
            with open(new_dir + "/" + json.loads(all_finished_prj_data[1])['fileId'] + '.json', 'w', encoding='UTF-8-sig') as outfile:
                json.dump(json.loads(all_finished_prj_data[1])["label-list"], outfile, ensure_ascii=False)

        # 결과 내용 목록에 추가
        result_text_list.append(
            project_name + " 프로젝트의 " + switch(task_id) + " 테스크(" + str(task_id) + ")의 데이터 " + str(
                task_file_counter) + " 개를 추출")
    else:
        print(project_name + " 프로젝트의 " + switch(task_id) + " 테스크(" + str(task_id) + ")의 데이터 해당 날짜의 파일이 없습니다.")

print("========================= RESULT =========================")
# 결과 내용 출력
for result_text in result_text_list:
    print(result_text)
print("==========================================================")

# 결과 내용 비교용 쿼리
# SELECT prj_idx, count(*)
# FROM TB_PRJ_DATA
# WHERE prj_idx in (1933,1942,1944,1945,1946,1947,1948,1949,1950,1951,1952) and prog_state_cd = "ALL_FINISHED"
# GROUP BY prj_idx;

### 0610 새로 만든거 ###
# 2010: "발코니_베란다/",
# 2011: "욕실/",
# 2012: "침실/",
# 2013: "옷방/",
# 2014: "식사실/",
# 2015: "현관/",
# 2016: "아이방/",
# 2017: "주방/",
# 2018: "거실/",
# 2019: "서재_공부방/",
# 2020: "다용도실/"

# SELECT * FROM TB_PRJ_DATA WHERE prj_idx=1949;
# SELECT * FROM TB_PRJ_DATA WHERE data_idx=16876106;
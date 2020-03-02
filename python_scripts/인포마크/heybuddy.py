from crowdworks.commonUtil import *

import os
import shutil
import json
import uuid


def switch(x):
    return {
        1837: '7~12,남/',
        1839: '13~20,남/',
        1841: '21~30,남/',
        1843: '31~40,남/',
        1845: '41~50,남/',
        1847: '7~12,여/',
        1848: '13~20,여/',
        1849: '21~30,여/',
        1850: '31~40,여/',
        1851: '41~50,여/',
    }.get(x, 9)


task_id = 1847

sql_result_json = "select work_user, result_json from TB_PRJ_DATA where prj_idx=" + str(
    task_id) + " and prog_state_cd='ALL_FINISHED'"

rows = getDatabaseData(sql_result_json, "prd", "mhjeong", "cworks@34")

idx = 0

for row in rows:

    idx = idx + 1

    sql_get_user_id = "select login_id from TB_MEMBER where member_id=" + str(row[0])
    user_id = getDatabaseData(sql_get_user_id, "prd", "mhjeong", "cworks@34")[0][0]

    newDir = "/Users/myeonghyeonjeong/Desktop/output/" + switch(task_id) + user_id + '_' + str(idx)

    try:
        if os.path.exists(newDir):
            print('이미 폴더가 있습니다.')
        else:
            os.makedirs(os.path.join(newDir))
    except FileNotFoundError:
        print('파일을 찾을 수 없습니다.')

    sql_get_all_file_name = "SELECT file_id, store_file_name from CW_FILE_RESULT where task_id=" + str(
        task_id) + " and reg_user=" + str(row[0])
    all_file_name_dict = dict((file_id, file_name) for file_id, file_name in
                              getDatabaseData(sql_get_all_file_name, "prd", "mhjeong", "cworks@34"))

    for i in range(0, 3):
        for j in range(0, 2):
            for data in json.loads(row[1])['data']['categoryList'][i]['categoryDataList'][j]['data']:
                origin_dir = "/Users/myeonghyeonjeong/Desktop/data_ext/" + all_file_name_dict[int(data['file_id'])]
                shutil.move(origin_dir, newDir + "/" + data['id'] + '.wav')
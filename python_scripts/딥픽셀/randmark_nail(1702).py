"""
[딥픽셀] 손톱 바운딩 (프로젝트아이디: 1702, 태스크아이디(1개): 2386)
"""
from crowdworks.commonUtil import *

import os
import json
import shutil
import datetime

now = datetime.datetime.now()
year = str(now.year)
month = str(now.month).zfill(2)
day = str(now.day).zfill(2)

SOURCE_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/딥픽셀/소스/"

EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/딥픽셀/손톱(1702)/labeled_data_1702_"
EXT_PATH = EXT_PATH + year + month + day + "/"
try:
    shutil.rmtree(EXT_PATH)
except FileNotFoundError:
    os.mkdir(EXT_PATH)

try:
    os.mkdir(EXT_PATH)
except FileExistsError:
    pass

task_ids = "2386"

QUERY = "SELECT CP.project_id, CP.project_name, TPM.prj_idx, TPM.prj_name, TD.prog_state_cd, TD.result_json, bin2uuid(TM1.uuid) AS work_user_uuid, bin2uuid(TM2.uuid) AS check_user_uuid, TD.work_edate, TD.check_edate, TD.mod_date, CFU.store_file_name, CFU.file_ext, CS.uuid_str FROM  TB_PRJ_DATA  AS TD INNER JOIN TB_PRJ_MST AS TPM ON TD.prj_idx = TPM.prj_idx INNER JOIN CW_PROJECT AS CP ON CP.project_id = TPM.project_id LEFT JOIN TB_MEMBER  AS TM1 ON TD.work_user = TM1.member_id LEFT JOIN TB_MEMBER  AS TM2 ON TD.check_user = TM1.member_id INNER JOIN CW_SOURCE AS CS ON CS.source_id = TD.src_idx INNER JOIN CW_FILE_UNPACKED AS CFU ON CS.file_id = CFU.file_id WHERE TPM.prj_idx IN (" + task_ids + ") AND TD.prog_state_cd = 'ALL_FINISHED' AND TD.problem_yn = 0 ORDER BY TD.check_edate DESC"
RESULT = getDatabaseData(QUERY, "", "", "")

# 정정데이터
# task_ids = "1714"
#
# QUERY = "SELECT CP.project_id, CP.project_name, TPM.prj_idx, TPM.prj_name, TD.prog_state_cd, TD.result_json, bin2uuid(TM1.uuid) AS work_user_uuid, bin2uuid(TM2.uuid) AS check_user_uuid, TD.work_edate, TD.check_edate, TD.mod_date, CFU.store_file_name, CFU.file_ext, CS.uuid_str FROM  TB_PRJ_DATA  AS TD INNER JOIN TB_PRJ_MST AS TPM ON TD.prj_idx = TPM.prj_idx INNER JOIN CW_PROJECT AS CP ON CP.project_id = TPM.project_id LEFT JOIN TB_MEMBER  AS TM1 ON TD.work_user = TM1.member_id LEFT JOIN TB_MEMBER  AS TM2 ON TD.check_user = TM1.member_id INNER JOIN CW_SOURCE AS CS ON CS.source_id = TD.src_idx INNER JOIN CW_FILE_UNPACKED AS CFU ON CS.file_id = CFU.file_id WHERE TPM.prj_idx IN (" + task_ids + ") AND TD.problem_yn = 0 ORDER BY TD.check_edate DESC"
# RESULT = getDatabaseData(QUERY, "", "", "")

print("projectId", "projectName", "taskId", "taskName", "progStateCd", "workUserUuid", "checkUserUuid", "workEdate",
      "checkEdate", "modDate", "fileName", "fileExt", "jsonData ", sep="\t")
for data in RESULT:
    projectId = data[0]
    projectName = data[1]
    taskId = data[2]
    taskName = data[3]
    progStateCd = data[4]
    jsonData = json.loads(data[5])
    workUserUuid = data[6]
    checkUserUuid = data[7]
    workEdate = data[8]
    checkEdate = data[9]
    modDate = data[10]
    fileName = data[11]
    fileExt = data[12]
    finger = []
    print(projectId, projectName, taskId, taskName, progStateCd, workUserUuid, checkUserUuid, workEdate, checkEdate,
          modDate, fileName, fileExt, jsonData, sep="\t")

    cnt = 0

    for data in jsonData["data"]:
        for trueData in data["data"]:
            index = data["data"][cnt]["value"].split("finger_")[1]
            values = {
                "index": int(index),
                "dots": data["dots"]
            }
            finger.append(values)
            cnt += 1
        cnt = 0
    if len(jsonData["emptyNailIdx"]) != 0:
        for data in jsonData["emptyNailIdx"]:
            emptyIndex = int(data.split("finger_")[1])
            values = {
                "index": emptyIndex,
                "dots": None
            }
            finger.append(values)
    finger = sorted(finger, key=lambda student: (student["index"]))
    f = open(EXT_PATH + str(fileName.split("." + fileExt)[0]) + '_N.pts', 'w', encoding='utf-8')
    for ff in finger:
        i = ff["index"]
        if ff["dots"] is not None:
            for d in ff["dots"]:
                f.write((str(i)) + "\t\t" + str(round(d["x"])) + "\t\t" + str(round(d["y"])) + "\n")
        else:
            f.write(str(i) + "\t\t" + str(-1) + "\t\t" + str(-1) + "\n")

    f.close()
    print(EXT_PATH + str(fileName.split("." + fileExt)[0]) + '_N.pts')


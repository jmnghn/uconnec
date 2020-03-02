"""
[딥픽셀] 얼굴어노테이션 (프로젝트아이디: 1909, 태스크아이디(2개): 3611, 3620)
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

SOURCE_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/딥픽셀/소스_얼굴/"

EXT_PATH = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/딥픽셀/얼굴(1909)/labeled_data_1909_"
EXT_PATH = EXT_PATH + year + month + day + "/"
try:
    shutil.rmtree(EXT_PATH)
except FileNotFoundError:
    os.mkdir(EXT_PATH)

try:
    os.mkdir(EXT_PATH)
except FileExistsError:
    pass

# task_ids = [2387,2388,2389,2390,2391,2392,2393,2394,2395,2396] 2387 은 파일럿.
task_ids = "3611,3620"

QUERY = "SELECT CP.project_id, CP.project_name, TPM.prj_idx, TPM.prj_name, TD.prog_state_cd, TD.result_json, bin2uuid(TM1.uuid) AS work_user_uuid, bin2uuid(TM2.uuid) AS check_user_uuid, TD.work_edate, TD.check_edate, TD.mod_date, CFU.store_file_name, CFU.file_ext, CS.uuid_str FROM  TB_PRJ_DATA  AS TD INNER JOIN TB_PRJ_MST AS TPM ON TD.prj_idx = TPM.prj_idx INNER JOIN CW_PROJECT AS CP ON CP.project_id = TPM.project_id LEFT JOIN TB_MEMBER  AS TM1 ON TD.work_user = TM1.member_id LEFT JOIN TB_MEMBER  AS TM2 ON TD.check_user = TM1.member_id INNER JOIN CW_SOURCE AS CS ON CS.source_id = TD.src_idx INNER JOIN CW_FILE_UNPACKED AS CFU ON CS.file_id = CFU.file_id WHERE TPM.prj_idx IN (" + task_ids + ") AND (prog_state_cd = 'ALL_FINISHED' OR prog_state_cd = 'CHECK_END') ORDER BY TD.check_edate DESC"
RESULT = getDatabaseData(QUERY, "prd", "mhjeong", "cworks@34")

# QUERY = "SELECT CP.project_id, CP.project_name, TPM.prj_idx, TPM.prj_name, TD.prog_state_cd, TD.result_json, bin2uuid(TM1.uuid) AS work_user_uuid, bin2uuid(TM2.uuid) AS check_user_uuid, TD.work_edate, TD.check_edate, TD.mod_date, CFU.store_file_name, CFU.file_ext, CS.uuid_str FROM  TB_PRJ_DATA  AS TD INNER JOIN TB_PRJ_MST AS TPM ON TD.prj_idx = TPM.prj_idx INNER JOIN CW_PROJECT AS CP ON CP.project_id = TPM.project_id LEFT JOIN TB_MEMBER  AS TM1 ON TD.work_user = TM1.member_id LEFT JOIN TB_MEMBER  AS TM2 ON TD.check_user = TM1.member_id INNER JOIN CW_SOURCE AS CS ON CS.source_id = TD.src_idx INNER JOIN CW_FILE_UNPACKED AS CFU ON CS.file_id = CFU.file_id WHERE TPM.prj_idx IN (3611,3620) AND TD.prog_state_cd = 'CHECK_END' ORDER BY TD.check_edate DESC"
# RESULT = getDatabaseData(QUERY, "dev", "cwdbuser", "ckadlselql#3")

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
    uuid = data[13]

    print(projectId, projectName, taskId, taskName, progStateCd, workUserUuid, checkUserUuid, workEdate, checkEdate,
          modDate, fileName, fileExt, json.dumps(jsonData, ensure_ascii=True), sep="\t")

    # 추출 데이터 형식 맞춰서 폴더생성 (labeled_data_프로젝트아이디_추출일자)
    try:
        _fileName = str(fileName.split("." + fileExt)[0])  # 파일이름 앞만 자른거
        # fileNameDir = str(EXT_PATH + uuid + "/")  # CW_SOURCE 테이블의 uuid_str 컬럼 사용해서 개별폴더 생성
        # os.mkdir(fileNameDir)
    except FileExistsError:
        print("폴더 이미 있음")
        pass
    #

    # 감리용
    # shutil.copy2(SOURCE_PATH + fileName, fileNameDir + uuid + '.jpg')

    # _fileName
    # f = open(fileNameDir + uuid + '_H.pts', 'w', encoding='utf-8')
    f = open(EXT_PATH + _fileName + '_F.pts', 'w', encoding='utf-8')

    for json_data in jsonData["face"]["data"]:
        if json_data["useyn"] is True:
            f.write((str(json_data["idx"])) + "\t\t" + str(round(json_data["x"])) + "\t\t" + str(
                round(json_data["y"])) + "\n")
        else:
            f.write(str(json_data["idx"]) + "\t\t" + str(-1) + "\t\t" + str(-1) + "\n")

    f.close()

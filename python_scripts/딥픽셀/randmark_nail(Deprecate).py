from crowdworks.commonUtil import *

import os
import json

origin_path = "/Users/myeonghyeonjeong/Desktop/randMarkNailDeepixel/"
output_path = origin_path + "output/"
source_path = origin_path + "source/"

if os.path.isdir(origin_path) == False:
    os.makedirs(origin_path)

if os.path.isdir(output_path) == False:
    os.makedirs(output_path)

if os.path.isdir(source_path) == False:
    os.makedirs(source_path)

sql = "select CP.project_id, CP.project_name, TPM.prj_idx, TPM.prj_name, TD.prog_state_cd, TD.result_json, bin2uuid(TM1.uuid) AS work_user_uuid, bin2uuid(TM2.uuid) AS check_user_uuid, TD.work_edate, TD.check_edate, TD.mod_date, CFU.store_file_name, CFU.file_ext from  TB_PRJ_DATA  AS TD inner join TB_PRJ_MST AS TPM ON TD.prj_idx = TPM.prj_idx inner join CW_PROJECT AS CP ON CP.project_id = TPM.project_id left join TB_MEMBER  AS TM1 ON TD.work_user = TM1.member_id left join TB_MEMBER  AS TM2 ON TD.check_user = TM1.member_id inner join CW_SOURCE AS CS ON CS.source_id = TD.src_idx inner join CW_FILE_UNPACKED AS CFU ON CS.file_id = CFU.file_id where CP.project_id = 1702 AND TPM.prj_idx = 2386 and TD.prog_state_cd = 'ALL_FINISHED' AND problem_yn = 0 order by TD.check_edate desc"

prj_data_list = result_json = getDatabaseData(sql, "prd", "mhjeong", "cworks@34")
idx = 0

print("projectId", "projectName", "taskId", "taskName", "progStateCd", "workUserUuid", "checkUserUuid", "workEdate",
      "checkEdate", "modDate", "fileName", "fileExt", "jsonData ", sep="\t")
for prj_data in prj_data_list:
    projectId = prj_data[0]
    projectName = prj_data[1]
    taskId = prj_data[2]
    taskName = prj_data[3]
    progStateCd = prj_data[4]
    jsonData = json.loads(prj_data[5])
    workUserUuid = prj_data[6]
    checkUserUuid = prj_data[7]
    workEdate = prj_data[8]
    checkEdate = prj_data[9]
    modDate = prj_data[10]
    fileName = prj_data[11]
    fileExt = prj_data[12]
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
    f = open(output_path + str(fileName.split("." + fileExt)[0]) + '_N.pts', 'w', encoding='utf-8')
    for ff in finger:
        i = ff["index"]
        if ff["dots"] is not None:
            for d in ff["dots"]:
                f.write((str(i)) + "\t\t" + str(round(d["x"])) + "\t\t" + str(round(d["y"])) + "\n")
        else:
            f.write(str(i) + "\t\t" + str(-1) + "\t\t" + str(-1) + "\n")

    f.close()
    print(output_path + str(fileName.split("." + fileExt)[0]) + '_N.pts')
    idx += 1
    print(str(idx))


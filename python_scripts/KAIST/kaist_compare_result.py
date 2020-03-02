from crowdworks.commonUtil import *

import os
import json
import copy

ROOT_PATH = "/Users/myeonghyeonjeong/Desktop/KAIST_결과데이터/"
prev_data = (0, {}, {})

SQL = "SELECT TPD.src_idx, TPD.result_json, CFU.json_value, CS.uuid_str FROM TB_PRJ_DATA TPD INNER JOIN CW_SOURCE CS ON TPD.src_idx = CS.source_id INNER JOIN CW_FILE_UNPACKED CFU ON CS.file_id = CFU.file_id WHERE TPD.prj_idx in (2996) AND prog_state_cd = 'WORK_END' AND problem_yn=0 ORDER BY src_idx ASC"
# sql_result = getDatabaseData(SQL, "dev", "cwdbuser", "ckadlselql#3")
# sql_result = getDatabaseData(SQL, "stg", "cwdbuser", "ckadlselql#3")
sql_result = getDatabaseData(SQL, "prd", "mhjeong", "cworks@34")


# TODO: key 이름이 cw_comment 는 제외
def compare_dict(dict1, dict2):
    d1_keys = dict1.keys()
    d2_keys = dict2.keys()
    intersect_keys = set(d1_keys).intersection(set(d2_keys))  # 키 교집합 list 로 추출.
    modified = {}
    for i in intersect_keys:
        if dict1[i] != dict2[i]:
            if isinstance(dict1[i], dict) and isinstance(dict1[i], dict):  # 아직도(!) 리스트면 ? 재귀...
                modified[i] = compare_dict(dict1[i], dict2[i])
            else:
                modified.update({i: (dict1[i], dict2[i])})
    return copy.deepcopy(modified)


for data in sql_result:

    src_idx = data[0]
    result_json = data[1]
    json_cont = data[2]
    uuid = data[3]

    prev_src_idx = prev_data[0]
    prev_src_result_json = prev_data[1]

    if prev_src_idx == src_idx:
        try:
            dict1 = json.loads(prev_src_result_json)
            dict2 = json.loads(result_json)

            if len(compare_dict(dict1, dict2)) == 0:  # 같으면, A 를 특정폴더로 이동
                print('O, src_idx:', src_idx)

                # 1. uuid 폴더 생성
                CASE_SAME_PATH = ROOT_PATH + "같음/" + uuid
                os.mkdir(CASE_SAME_PATH)

                # 2. json 파일 생성
                with open(CASE_SAME_PATH + "/" + uuid + '.json', 'w', encoding='UTF-8-sig') as fp:
                    fp.write(json.dumps(json.loads(result_json), ensure_ascii=False, sort_keys=True, indent=4))

            else:  # 다르면
                print('X, src_idx:', src_idx)

                # 1. 1차 검수 데이터 폴더에 uuid 로 된 폴더 생성 후
                CASE_DIFF_PATH = ROOT_PATH + "다름/" + uuid
                os.mkdir(CASE_DIFF_PATH)

                # 2-1. json 파일 생성
                # A 결과
                with open(CASE_DIFF_PATH + "/A_" + uuid + '.json', 'w', encoding='UTF-8-sig') as fp:
                    fp.write(json.dumps(json.loads(prev_src_result_json), ensure_ascii=False, sort_keys=True, indent=4))
                # B 결과
                with open(CASE_DIFF_PATH + "/B_" + uuid + '.json', 'w', encoding='UTF-8-sig') as fp:
                    fp.write(json.dumps(json.loads(result_json), ensure_ascii=False, sort_keys=True, indent=4))
                # jsonCont
                with open(CASE_DIFF_PATH + "/" + uuid + '.json', 'w', encoding='UTF-8-sig') as fp:
                    fp.write(json.dumps(json.loads(json_cont), ensure_ascii=False, sort_keys=True, indent=4))

                # 2-2. jsonCont 용 json 파일 생성
                CONT_PATH = ROOT_PATH + "1차검수_jsonCont/"

                cont_to_json = {
                    "cont": {
                        "resultData": []
                    }
                }

                cont_to_json["cont"]["resultData"].append(json.loads(prev_src_result_json))
                cont_to_json["cont"]["resultData"].append(json.loads(result_json))
                cont_to_json["cont"].update(json.loads(json_cont)['cont'])

                with open(CONT_PATH + "/" + uuid + '.json', 'w', encoding='UTF-8-sig') as fp:
                    fp.write(json.dumps(cont_to_json, ensure_ascii=False))
        except TypeError:
            print("result_json 이 null 인 데이터:", src_idx)

    prev_data = data

# def output_json(path,json_string):
#     json_str = json.loads(json_string)
#     return json.dumps(json_str, sort_keys=True, indent=4);

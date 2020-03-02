from crowdworks.commonUtil import *

import os
import json
import shutil
from PIL import Image, ImageDraw

task_id = str(2236)

ROOT_PATH = "/Users/myeonghyeonjeong/Desktop/OCR/"
ORIGIN_IMAGE_PATH = ROOT_PATH + "originImage/"
JSON_PATH = ROOT_PATH + task_id + "/json/"
RESULT_IMAGE_PATH = ROOT_PATH + task_id + "/resultImage/"

mkdirList = [ROOT_PATH + task_id, JSON_PATH, RESULT_IMAGE_PATH]

sql = "SELECT D.data_idx, D.result_json, U.store_file_name FROM TB_PRJ_DATA D INNER JOIN TB_MEMBER M ON M.member_id = D.work_user INNER JOIN TB_TMPL_IMG_LABEL_DATA L ON D.data_idx  = L.data_idx INNER JOIN CW_SOURCE S ON S.source_id = L.src_idx INNER JOIN CW_FILE_UNPACKED U  ON U.file_id = S.file_id WHERE D.prj_idx in ( " + task_id + " ) AND D.prog_state_cd IN ('ALL_FINISHED');"

rows = getDatabaseData(sql, "prd", "mhjeong", "cworks@34")

# 1. 결과데이터 저장용 디렉토리 생성
for path in mkdirList:
    try:
        os.mkdir(path)
    except FileExistsError:
        print("이미 존재하는 폴더 입니다:", path)
        pass

# 2. 수집한 이미지 파일들 origin_path 최상위로 복사
for tuple_f in os.walk(ORIGIN_IMAGE_PATH):
    for f in tuple_f[2]:
        if f != ".DS_Store":
            shutil.copy2(tuple_f[0] + "/" + f, ORIGIN_IMAGE_PATH)

for row in rows:
    preview_words = []
    preview_dc = []

    data_idx = str(row[0])
    result_json = json.loads(row[1])
    store_file_name = row[2]

    result = {
        "lines": [],
        "DC": []
    }

    for line in result_json["lines"]:
        _line = {
            "orientation": [],
            "words": []
        }

        _line["orientation"] = line["orientation"]

        for word in line["words"]:
            _word = {
                "content": True,
                "letters": "",
                "quads": []
            }

            if (len(word["origin"]) != 0):
                if word["category"]["invisible"] == True:
                    result["DC"].append(word["origin"])
                    preview_dc.append(word["origin"])
                else:
                    _word["letters"] = word["category"]["text"]
                    _word["quads"].append(word["origin"])

                    preview_words.append(word["origin"])
            else:
                if word["category"]["invisible"] == True:
                    result["DC"] = word["origin"]
                    preview_dc = word["origin"]
                else:
                    _word["letters"] = word["category"]["text"]
                    _word["quads"].append(word["origin"])

                    preview_words.append(word["origin"])

            _word["letters"] = _word["letters"].replace("▣", "[unk]")

            if _word["letters"]:
                _line["words"].append(_word)

        if len(_line["words"]) > 0:
            result["lines"].append(_line)

    # 3. .json 결과데이터 생성
    with open(JSON_PATH + store_file_name + '.json', 'w', encoding='UTF-8-sig') as fp:
        fp.write(json.dumps(result, ensure_ascii=False))

    # 4. 이미지 결과데이터 생성
    for idx in range(len(preview_words)):
        x = []
        y = []

        for point in preview_words[idx]:
            x.append(point["x"])
            y.append(point["y"])

        x = map(int, x)
        y = map(int, y)
        if idx == 0:
            img = Image.open(ORIGIN_IMAGE_PATH + store_file_name)
        else:
            img = Image.open(RESULT_IMAGE_PATH + store_file_name.split('.')[0] + "-" + data_idx + ".jpg")

        img2 = img.copy()
        draw = ImageDraw.Draw(img2)

        points = tuple(zip(x, y))

        draw.polygon(points, fill="chartreuse")

        img3 = Image.blend(img, img2, 0.5)
        img3.save(RESULT_IMAGE_PATH + store_file_name.split('.')[0] + "-" + data_idx + ".jpg")

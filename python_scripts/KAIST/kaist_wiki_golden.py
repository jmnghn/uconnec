from pprint import pprint

from crowdworks.commonUtil import *

import os
import json
from openpyxl import Workbook

data = []
JSON_DATA_PATH = "/Users/myeonghyeonjeong/Documents/2019/09/카이스트_나무위키/190909_메일로받은거/crowdworks_mine_data.json"

with open(JSON_DATA_PATH, 'r', encoding='UTF-8-sig') as file:
    json_data = json.load(file)

for key in json_data.keys():
    data.append({
        "q": {
            key: {
                "abstract": json_data[key]["abstract"],
                "candidates": json_data[key]["candidates"]
            }
        },
        "a": {"kbox": json_data[key]["answer"], "namu_wiki": key}
    })

row = 1
idx = 0

contTxt = open('/Users/myeonghyeonjeong/Documents/2019/09/카이스트_나무위키/kaist_wiki_golden2.txt', 'w', encoding='utf-8')

for d in data:
    row += 1
    idx += 1
    contTxt.write("'"+(json.dumps(d["q"], ensure_ascii=False)).replace("\\","\\\\").replace("'","\\'")+"'" + "\t" + ",'"+(json.dumps(d["a"], ensure_ascii=False)).replace("\\","\\\\").replace("'","\\'")+"'" + "\n")
    print(json.dumps(d["q"], ensure_ascii=False) + "\t" + json.dumps(d["a"], ensure_ascii=False))

contTxt.close()
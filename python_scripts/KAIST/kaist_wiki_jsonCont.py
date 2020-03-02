from pprint import pprint

from crowdworks.commonUtil import *

import os
import json
from openpyxl import Workbook

data = []
JSON_DATA_PATH = "/Users/myeonghyeonjeong/Documents/2019/09/카이스트_나무위키/190909_메일로받은거/crowdworks_input.json"

with open(JSON_DATA_PATH, 'r', encoding='UTF-8-sig') as file:
    json_data = json.load(file)

for key in json_data.keys():
    data.append({
        key: json_data[key]
    })

row = 1
idx = 0

contTxt = open('/Users/myeonghyeonjeong/Documents/2019/09/카이스트_나무위키/kaist_wiki_jsonCont.txt', 'w', encoding='utf-8')
contTxt.write("0" + "\t" + "0" + "\t" + "0" + "\n")

for d in data:
    row += 1
    idx += 1
    contTxt.write(str(idx) + "\t" + str(idx) + "\t" + json.dumps(d, ensure_ascii=False) + "\n")
    print(str(idx) + "\t" + str(idx) + "\t" + json.dumps(d, ensure_ascii=False))

contTxt.close()
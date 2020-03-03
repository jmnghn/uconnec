from crowdworks.commonUtil import *

import os
import json

# 관리자페이지 - 파일정보 - 아이디 (압축파일의 id 값)
compression_file_id = '2613'
json_cont_path = '/Users/myeonghyeonjeong/Desktop/골프더미/jsonCont_golf.json'

sql_result = "SELECT CS.uuid_str, CFU.store_file_name FROM CW_FILE_UNPACKED AS CFU INNER JOIN CW_SOURCE AS CS ON CS.file_id = CFU.file_id WHERE CFU.compression_file_id = " + compression_file_id

print(sql_result)

# result = getDatabaseData(sql_result, "", "", "")
result = getDatabaseData(sql_result, "", "", "")

with open(json_cont_path, encoding='utf-8-sig') as json_file:
    json_data = json.load(json_file)



for item in result:

    for key in json_data['cont']['groups']:
        for i in json_data['cont']['groups'][key]['data']:
            if i['name'] == item[1].split('.')[0]:
                i['preview'] = item[0]


with open(json_cont_path, 'w', encoding='UTF-8-sig') as outfile:
    json.dump(json_data, outfile, ensure_ascii=False)
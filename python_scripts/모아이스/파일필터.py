import json
import os
import shutil

dir_path = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/모아이스/골프자세추출/5차/crowdworks_data_190909_5/"
copy_path = "/Users/myeonghyeonjeong/Desktop/DATA_EXT/모아이스/골프자세추출/5차/crowdworks_data_190909_5/out/"


def search(dp):
    filenames = os.listdir(dp)
    filenames.sort()
    for filename in filenames:
        full_filename = os.path.join(dp, filename)

        # print(full_filename)

        if filename == '.DS_Store':
            continue

        if os.path.isdir(full_filename):
            if os.path.exists(copy_path + full_filename.replace(dir_path, '')):
                print('폴더이미있음')
            else:
                if 'FrameMetadata' not in full_filename.replace(dir_path, ''):
                    os.makedirs(copy_path + full_filename.replace(dir_path, ''))
            search(full_filename)
        else:
            fn, ext = os.path.splitext(filename)
            if ext == '.jpeg' or ext == '.JPEG' or ext == '.jpg' or ext == '.JPG':
                # 소스가공용... 001.jpg, 002.jpg, 003.jpg, ...
                shutil.copy2(full_filename,
                             copy_path + os.path.dirname(full_filename).replace(dir_path, '') + '/' + str(
                                 fn.zfill(3)) + ext)
                # / 소스가공용... 001.jpg, 002.jpg, 003.jpg, ...

                # 이 주석 해제 하면 ImageSize 만들기용...
                shutil.copy2(full_filename,
                             copy_path + os.path.dirname(full_filename).replace('FrameImages', '').replace(dir_path,
                                                                                                           '') + '/' + str(
                                 fn.zfill(3)) + ext)

                shutil.rmtree(copy_path + os.path.dirname(full_filename).replace(dir_path, ''))
                return
                # / 이 주석 해제 하면 ImageSize 만들기용...

            # elif ext == '.csv' or '.CSV' :
            #     shutil.copy2(full_filename, copy_path+ os.path.dirname(full_filename).replace(dir_path, '')+'/'+str(fn.zfill(3))+ext)


search(dir_path)

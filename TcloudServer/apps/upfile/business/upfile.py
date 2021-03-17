import os
import traceback
from flask import request, g, current_app
from public_config import LOCAL_FOLDER


class GetUploadFile(object):
    @classmethod
    def getfile(cls):
        FOLDER = LOCAL_FOLDER + r'/apk'
        if os.path.exists(FOLDER):
            try:
                if request.method == 'POST':
                    f = request.files['file']
                    file_path = os.path.join(FOLDER, f.filename)
                    f.save(file_path)
                    return print(f.filename)
            except Exception as e:
                current_app.logger.error(e)
                current_app.logger.error(traceback.format_exc())
                return []
        else:
            os.makedirs(FOLDER)
            return cls.getfile()

    @classmethod
    def getimage(cls):
        FOLDER = LOCAL_FOLDER + r'/image'
        if os.path.exists(FOLDER):
            try:
                if request.method == 'POST':
                    f = request.files['file']
                    file_path = os.path.join(FOLDER, f.filename)
                    f.save(file_path)
                    return print(f.filename)
            except Exception as e:
                current_app.logger.error(e)
                current_app.logger.error(traceback.format_exc())
                return []
        else:
            os.makedirs(FOLDER)
            return cls.getfile()
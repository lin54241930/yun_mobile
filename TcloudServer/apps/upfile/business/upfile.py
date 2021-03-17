import os
import traceback
from flask import request, g, current_app
from public_config import LOCAL_FOLDER


class GetUploadFile(object):
    @classmethod
    def getfile(cls):
        if os.path.exists(LOCAL_FOLDER):
            try:
                if request.method == 'POST':
                    f = request.files['file']
                    file_path = os.path.join(LOCAL_FOLDER, f.filename)
                    f.save(file_path)
                    return print(f.filename)
            except Exception as e:
                current_app.logger.error(e)
                current_app.logger.error(traceback.format_exc())
                return []
        else:
            os.makedirs(LOCAL_FOLDER)
            return cls.getfile()
# coding=utf-8
import os
from flask import Flask, send_file, Response
from public_config import LOCAL_FOLDER
# 同样，这里的LOCAL_FILDER还是那个

app = Flask(__name__)  # 实例化flask app


# filename是客户端传来的需要下载的文件名
@app.route('/v1/getfile/<filename>', methods=['GET'])
def get_file(filename):
    FOLDER = LOCAL_FOLDER + r'/apk'
    file_path = os.path.join(FOLDER, filename)
    print(file_path)
    if os.path.isfile(file_path):
        print(file_path)
        return send_file(file_path, as_attachment=True)
    else:
        return "The downloaded file does not exist"


@app.route('/v1/getimage/<filename>', methods=['GET'])
def get_image(filename):
    FOLDER = LOCAL_FOLDER + r'/image'
    file_path = os.path.join(FOLDER, filename)
    if os.path.isfile(file_path):
        with open(file_path, 'rb') as img_f:
            img_stream = img_f.read()
            resp = Response(img_stream, mimetype="image/jpg")
        print(file_path)
        return resp
    else:
        return "The image does not exist"


@app.route('/v1/defaultimage/<filename>', methods=['GET'])
def get_default_image(filename):
    FOLDER = './'
    file_path = os.path.join(FOLDER, filename)
    if os.path.isfile(file_path):
        with open(file_path, 'rb') as img_f:
            img_stream = img_f.read()
            resp = Response(img_stream, mimetype="image/jpg")
        print(file_path)
        return resp
    else:
        return "The image does not exist"


if __name__ == '__main__':
    app.run(debug=True, port=9044)
import os
from flask import Flask, send_file, send_from_directory
from public_config import LOCAL_FOLDER
# 同样，这里的LOCAL_FILDER还是那个

app = Flask(__name__)  # 实例化flask app


# filename是客户端传来的需要下载的文件名
@app.route('/v1/getfile/<filename>', methods=['GET'])
def get_file(filename):
    file_path = os.path.join(LOCAL_FOLDER, filename)
    print(file_path)
    if os.path.isfile(file_path):
        print(file_path)
        return send_file(file_path, as_attachment=True)
    else:
        return "The downloaded file does not exist"


if __name__ == '__main__':
    app.run(debug=True, port=9044)
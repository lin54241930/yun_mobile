from flask import Blueprint
from apps.upfile.business.upfile import GetUploadFile

upfile = Blueprint("upfile", __name__)


@upfile.route('/pushfile', methods=['POST'])
def pushfile():

    response = {
        "code": 0,
        "data": GetUploadFile.getfile()
    }

    return response


@upfile.route('/pushimage', methods=['POST'])
def pushimage():

    response = {
        "code": 0,
        "data": GetUploadFile.getimage()
    }

    return response
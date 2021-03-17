from flask import Blueprint
from apps.upfile.business.upfile import GetUploadFile

upfile = Blueprint("upfile", __name__)


@upfile.route('/pushfile', methods=['POST'])
def pmreport_cont():

    response = {
        "code": 0,
        "data": GetUploadFile.getfile()
    }

    return response
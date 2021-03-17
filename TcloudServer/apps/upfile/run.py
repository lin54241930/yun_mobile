from apps.upfile.settings import config
from flask_cors import CORS
if config.SERVER_ENV != 'dev':
    from gevent import monkey

    monkey.patch_all()
else:
    pass

from apps.upfile.views.upfile import upfile
from library.api.tFlask import tflask


def create_app():
    app = tflask(config)
    register_blueprints(app)
    CORS(app, supports_credentials=True)
    return app


def register_blueprints(app):
    app.register_blueprint(upfile, url_prefix="/v1/upfile")


if __name__ == '__main__':
    create_app().run(port=config.PORT)

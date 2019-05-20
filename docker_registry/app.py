from flask import Flask, request, jsonify
import logging
from logging import Formatter, FileHandler

app = Flask(__name__)
@app.route('/', methods=['POST','GET'])
def get_tasks():
        payload = dict()
        payload['state'] = "success"
        resp = jsonify(payload)
        return resp, 200
if __name__ == '__main__':
    file_handler = FileHandler('output.log')
    handler = logging.StreamHandler()
    file_handler.setLevel(logging.DEBUG)
    handler.setLevel(logging.DEBUG)
    file_handler.setFormatter(Formatter('%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]'))
    handler.setFormatter(Formatter('%(asctime)s %(levelname)s: %(message)s [in %(pathname)s:%(lineno)d]'))
    app.logger.addHandler(handler)
    app.logger.addHandler(file_handler)
    app.logger.debug('first test message...')
    app.run(host="0.0.0.0",debug=True, port=9000)


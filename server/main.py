from flask import Flask, request
from flask_cors import CORS, cross_origin
from markupsafe import escape
import os


def save(filename, data):
    os.makedirs(os.path.dirname(filename), exist_ok=True)
    with open(filename, 'w') as f:
        f.write(str(data))


def load(filename):
    with open(filename, 'r') as f:
        data = f.read()
    return data


app = Flask(__name__)
cors = CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'


@app.route('/game/<uuid:game_id>/user/<user_id>/file/<file_name>', methods=['GET', 'POST'])
@cross_origin()
def router(game_id, user_id, file_name):
    try:
        gameid = escape(game_id)
        userid = escape(user_id)
        filename = escape(file_name)

        path = "data/{}/{}/{}".format(gameid, userid, filename)
        if request.method == 'POST':
            save(path, request.json)
            return "ok"
        else:
            return load(path)
    except:
        return "error"

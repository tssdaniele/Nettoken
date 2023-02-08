from flask import Flask
import json
import os

app = Flask(__name__)

@app.route('/', methods=['GET'])
def index():
    absolute_path = os.path.dirname(__file__)
    relative_path = "resources/NettokenTaskData.json"
    full_path = os.path.join(absolute_path, relative_path)
    with open(full_path, 'r') as f:
        data = json.load(f)
    return data

if __name__ == '__main__':
        app.run(debug=True, threaded=True)

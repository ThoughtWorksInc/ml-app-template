import os, json, re

import joblib
import pandas as pd
from flask import Flask, jsonify, request

app = Flask(__name__)
column_order = joblib.load('models/column_order.joblib') 
model = joblib.load('models/model.joblib') 

@app.route('/', methods=['GET'])
def hello_world():
    return jsonify({"response": "hello world!"})

@app.route('/predict', methods=['POST'])
def predict():
    request_payload = request.json
    input_features = pd.DataFrame([], columns=column_order)
    input_features = input_features.append(request_payload, ignore_index=True)
    input_features = input_features.fillna(0)

    prediction = model.predict(input_features.values.tolist()).tolist()[0]

    return jsonify({'predicted price (thousands)': prediction})

if __name__ == '__main__':    
    port = os.environ.get('PORT', 8080)
    if port == 8080:
        app.run(port=port, host='0.0.0.0', debug=True)
    else:
        app.run()

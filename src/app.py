import os, json

import joblib
import pandas as pd
from flask import Flask, jsonify, request
from fluent import sender
from fluent import event

app = Flask(__name__)
column_order = joblib.load('models/column_order.joblib') 
model = joblib.load('models/model.joblib') 

@app.route('/', methods=['GET'])
def hello_world():
    return jsonify({"response": "bad model!"})

@app.route('/predict', methods=['POST'])
def predict():
    request_payload = request.json
    input_features = pd.DataFrame([], columns=column_order)
    input_features = input_features.append(request_payload, ignore_index=True)
    input_features = input_features.fillna(0)

    prediction = model.predict(input_features.values.tolist()).tolist()[0]

    logger = sender.FluentSender('app', host='host.docker.internal', port=24224)
    feature_names = column_order.tolist()
    feature_values = input_features.values.tolist()[0]
    log_payload = {'prediction': prediction, **dict(zip(feature_names, feature_values))}
    if not logger.emit('prediction', log_payload):
        print('logger error')
        print(logger.last_error)
        logger.clear_last_error() # clear stored error after handled errors

    return jsonify({'predicted price (thousands)': prediction})

if __name__ == '__main__':    
    port = os.environ.get('PORT', 8080)
    if port == 8080:
        app.run(port=port, host='0.0.0.0', debug=True)
    else:
        app.run()


from flask import Flask, jsonify, request
import time

  
app = Flask(__name__)
timestamp = time.time()  
  
@app.route('/', methods=['GET'])
def helloworld():
    if(request.method == 'GET'):
        data = {"message": "Automate all the things!",
                "timestamp": timestamp}
        return jsonify(data)
  
  
if __name__ == '__main__':
    app.run(debug=True, port = 8000, host = "0.0.0.0")

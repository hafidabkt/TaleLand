from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)

users = []

@app.route('/signup', methods=['POST'])
def signup():
    data = request.get_json()
    name = data.get('name')
    password = data.get('password')
    email = data.get('email')
    gender = data.get('gender')

    if not name or not password or not email or not gender:
        return jsonify({'error': 'All fields are required'}), 400

    user = {'name': name, 'password': password, 'email': email, 'gender': gender}
    users.append(user)

    return jsonify({'message': 'Signup successful', 'user': user}), 201

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email')
    password = data.get('password')
    
    if not email or not password:
        return jsonify({'error': 'All fields are required'}), 400

    # Find user by email
    user = next((u for u in users if u['email'] == email), None)
    if user == None:
        return jsonify({'error': 'notfounduser'}), 401
    if user['password'] == password:
        return jsonify({'message': 'Login successful', 'user': user}), 200
    else:
        return jsonify({'error': 'Invalid password'}), 402

if __name__ == '__main__':
    app.run(debug=True)

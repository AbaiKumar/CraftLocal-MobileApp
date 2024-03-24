from model import *
from flask import Flask, jsonify, request, send_from_directory
from flask_cors import CORS

app = Flask(__name__)
app.secret_key = 'abai=kumar'
UPLOAD_FOLDER = 'uploads'
app.config['UPLOAD_FOLDER'] = UPLOAD_FOLDER
CORS(app)
ALLOWED_EXTENSIONS = {'jpg', 'jpeg', 'png', 'webp'}

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route("/signup", methods=["POST"])
def signup():
    if data.createAccount(request.form["name"], request.form["phone"], request.form["password"]):
        return jsonify({"msg": True})
    else:
        return jsonify({"msg": True})

@app.route("/resetPassword", methods=["POST"])
def resetPassword():
    pwd = request.form['password']
    phone = request.form['phone']
    user = data.userCollection.find_one({"phone": phone})
    if user:
        data.userCollection.update_one({"phone": phone}, {"$set": {"password": pwd}})
        return jsonify({"msg": True})
    else:
        return jsonify({"msg": False})

@app.route("/login", methods=["POST"])
def login():
    if data.loginAccount(request.form["phone"], request.form["password"]) == True:
        return jsonify({"msg": True})
    else:
        return jsonify({"msg": False})

@app.route('/addproduct', methods=['POST'])
def upload_image():
    try:
        image_file = request.files['image']
        name = request.form['name']
        desc = request.form['desc']
        stock = int(request.form['stock'])
        price = float(request.form['price'])
        image_file.save('uploads/' + image_file.filename)
        data.productCollection.insert_one({'image_path': 'uploads/' + image_file.filename, 'name': name, 'desc': desc, 'stock': stock, 'price': price})
        return 'Image uploaded successfully', 200
    
    except Exception as e:
        print('Error uploading image:', e)
        return 'Error uploading image', 500
    
@app.route('/contact', methods=['POST'])
def contact():
    name = request.form['name']
    email = request.form['email']
    message = request.form['message']
    if data.contact(name, email, message) == True:
        return jsonify({"msg": True})
    else:
        return jsonify({"msg": False})
    
@app.route('/delete', methods=['POST'])
def delete():
    phone = request.form['phone']
    user = data.userCollection.find_one({"phone": phone})
    if user:
        data.userCollection.delete_one({"phone": phone})
        return jsonify({"result": True})
    else:
        return jsonify({"result": False})

@app.route('/static/<path:filename>')
def static_file(filename):
    return app.send_static_file(filename)

@app.route('/uploads/<path:filename>')
def getImage(filename):
    return send_from_directory(UPLOAD_FOLDER, filename)

@app.route('/getData', methods=["POST"])
def getData():
    record = data.getData()
    if record[0]:
        return jsonify({'status': 'success', 'data': record[1]})
    else:
        return jsonify({'status': 'error', 'data': "Error"})
    
if __name__ == "__main__":
    app.run(debug=True, port="8000")

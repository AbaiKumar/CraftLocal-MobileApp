from tkinter import Image
from bson import ObjectId
from pymongo import MongoClient


class Data:
    def __init__(self):
        self.client = MongoClient("mongodb://localhost:27017/")
        self.database = self.client["CraftLocal"]
        self.userCollection = self.database["UserApp"]
        self.productCollection = self.database["ProductApp"]
        self.contactCollection = self.database["ContactApp"]

    def createAccount(self, name, phone, password):
        user_document = {
            "name": name,
            "phone": phone,
            "password": password
        }
        if (self.userCollection.find_one({"phone": phone}) == None):
            self.userCollection.insert_one(user_document)
            return True
        else:
            return False

    def loginAccount(self, phone, pwd):
        query = {"phone": phone}
        result = self.userCollection.find_one(query)

        if result:
            if result.get("password") == pwd:
                return True
        return False

    def contact(self, name, email, msg):
        query = {
            "name": name,
            "email": email,
            "msg": msg
        }

        result = self.contactCollection.insert_one(query)
        if result:
            return True
        return False

    def getData(self):
        try:
            data = list(self.productCollection.find(
                {}, {'_id': 1, 'name': 1, 'price': 1, 'stock': 1, 'desc': 1, 'image_path': 1}))
            for item in data:
                item['_id'] = str(item['_id'])
            return [True, data]
        except Exception as e:
            return [False, []]


data = Data()
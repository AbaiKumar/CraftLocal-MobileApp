import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CraftLocalProvider with ChangeNotifier {
  String? _phone;
  List products = [];

  CraftLocalProvider() {
    getProduct();
  }

  Future<List> getProduct() async {
    products = [];
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/getData'),
    );

    if (response.statusCode == 200) {
      var res = json.decode(response.body);
      for (Map<String, dynamic> i in res["data"]) {
        products.add(i);
      }
    }
    return products;
  }

  Future<String> resetPassword(String pwd, String phone) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/resetPassword'),
      body: {
        'password': pwd,
        'phone': phone,
      },
    );

    if (response.statusCode == 200) {
      return "Yes";
    } else {
      return "No";
    }
  }

  Future<String> signup(String name, String phone, String pwd) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/signup'),
      body: {
        'name': name,
        'phone': phone,
        'password': pwd,
      },
    );

    var res = json.decode(response.body);
    if (res['msg'] == true) {
      _phone = phone;
      return "Yes";
    } else {
      return "No";
    }
  }

  Future<String> login(String phone, String pwd) async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/login'),
      body: {
        'phone': phone,
        'password': pwd,
      },
    );

    var res = json.decode(response.body);
    if (res['msg'] == true) {
      _phone = phone;
      return "Yes";
    } else {
      return "No";
    }
  }

  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false,
      multiLine: false,
    );

    return emailRegex.hasMatch(email);
  }

  Future<String> contact(String name, String email, String msg) async {
    if (name.isEmpty || email.isEmpty || msg.isEmpty || !isValidEmail(email)) {
      return "No";
    }
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/contact'),
      body: {
        'name': name,
        'email': email,
        'message': msg,
      },
    );

    if (response.statusCode == 200) {
      _phone = _phone;
      return "Yes";
    } else {
      return "No";
    }
  }

  Future<String> delete() async {
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/delete'),
      body: {
        'phone': _phone,
      },
    );

    if (response.statusCode == 200) {
      _phone = _phone;
      return "Yes";
    } else {
      return "No";
    }
  }

  Future<String> addProduct(
      String name, String desc, String stock, String price, String url) async {
    if (name.isEmpty ||
        desc.isEmpty ||
        stock.isEmpty ||
        price.isEmpty ||
        url.isEmpty) {
      return "No";
    }
    var uri = Uri.parse('http://127.0.0.1:8000/addproduct');
    var request = http.MultipartRequest('POST', uri);
    var multipartFile = await http.MultipartFile.fromPath('image', url);
    request.files.add(multipartFile);
    request.fields['name'] = name;
    request.fields['desc'] = desc;
    request.fields['stock'] = stock.toString();
    request.fields['price'] = price.toString();

    var response = await request.send();
    if (response.statusCode == 200) {
      _phone = _phone;
      return "Yes";
    } else {
      return "No";
    }
  }
}

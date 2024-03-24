import 'package:craftlocal/modal/modal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Signup Tests', () {
    late CraftLocalProvider obj;

    setUp(() {
      obj = CraftLocalProvider();
    });

    test('Signup Success for 383868338', () async {
      const String username = 'abai';
      const String phone = '9087654567';
      const String password = '1';

      var res = await obj.signup(username, phone, password);
      print("For username : $username and password : $password");
      expect(res, "Yes");
    });

    test('Signup Failed', () async {
      const String username = 'abai';
      const String phone = '9087654567';
      const String password = 'password';

      var res = await obj.signup(username, phone, password);
      print("For username : $username and password : $password");
      expect(res, "No");
    });

    test('Signup Failed', () async {
      const String username = 'abai';
      const String phone = '9087654567';
      const String password = '1';

      var res = await obj.signup(username, phone, password);
      print("For username : $username and password : $password");
      expect(res, "No");
    });
  });
}

import 'package:craftlocal/contact.dart';
import 'package:craftlocal/home.dart';
import 'package:craftlocal/login/login.dart';
import 'package:craftlocal/modal/modal.dart';
import 'package:craftlocal/sellerproducts/addproduct.dart';
import 'package:flutter/material.dart';
import 'details.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CraftLocalProvider>(
      create: (context) => CraftLocalProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CraftLocal',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: LoginWidget(),
      ),
    );
  }
}

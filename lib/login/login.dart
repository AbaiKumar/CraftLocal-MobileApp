// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, use_build_context_synchronously, depend_on_referenced_packages, must_be_immutable
import 'package:craftlocal/contact.dart';
import 'package:craftlocal/details.dart';
import 'package:craftlocal/home.dart';
import 'package:craftlocal/modal/modal.dart';
import 'package:craftlocal/sellerproducts/addproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class MyLogScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.white,
      ),
    );
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.white, // #f9fd37
          resizeToAvoidBottomInset:
              true, //Not move widgets up when keyboard appear
          body: SafeArea(
            child: LoginWidget(),
          ),
        );
      },
    );
  }
}

class LoginWidget extends StatefulWidget {
  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  var passwordVis = false;
  var check = 0;
  var formkey = GlobalKey<FormState>();
  var usrphn = FocusNode();
  var usrnm = FocusNode();
  var pass = FocusNode();
  var but = FocusNode();
  TextEditingController txt1 = TextEditingController(),
      txt2 = TextEditingController(),
      txt3 = TextEditingController();
  dynamic usrname, usrphone, pwd, cnf;

  void change(int val) {
    setState(() {
      txt1.text = "";
      txt2.text = "";
      txt3.text = "";
      check = val;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveLogin(BuildContext context, CraftLocalProvider obj) async {
    //for login
    if (txt2.text == "" || txt3.text == "") {
      return;
    }
    String res = await obj.login(txt2.text, txt3.text);
    if (res == "Yes") {
      Navigator.of(context).pushNamedAndRemoveUntil("/home", (route) => false);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Login Failed"),
        ),
      );
    }
    return;
  }

  Future<void> saveSignup(BuildContext context, CraftLocalProvider obj) async {
    //for signup
    if (txt1.text == "" || txt2.text == "" || txt3.text == "") {
      return;
    }
    String res = await obj.signup(txt1.text, txt2.text, txt3.text);
    if (res == "Yes") {
      setState(() {
        check = 0;
      });
    }
    return;
  }

  @override
  void dispose() {
    //dipose all widget foces..
    super.dispose();
    usrnm.dispose();
    usrphn.dispose();
    formkey.currentState?.dispose();
    pass.dispose();
    but.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var obj = Provider.of<CraftLocalProvider>(context, listen: false);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white),
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: height * 0.09,
            ),
            SizedBox(
              //image widget
              width: width * 0.45,
              height: height * 0.20,
              child: FittedBox(
                fit: BoxFit.fill,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(
                    Radius.circular(width * 0.1),
                  ),
                  child: Image.asset(
                    "assets/images/Craft.png",
                    alignment: Alignment.center,
                  ),
                ),
              ),
            ),
            SizedBox(
              //empty space
              height: height * 0.03,
            ),
            //Form Widget.....
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 0.5,
                ),
                borderRadius: BorderRadius.circular(30),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(20),
              width: width * 0.85,
              child: Form(
                //form widget start here
                key: formkey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    if (check == 1) ...[
                      TextFormField(
                        //for username
                        keyboardType: TextInputType.name,
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                              color: Colors.red,
                            ),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(),
                            borderRadius: BorderRadius.circular(50.0),
                          ),
                          label: const Text(
                            "Name",
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone,
                          ),
                        ),
                        onFieldSubmitted: (_) {
                          FocusScope.of(context).requestFocus(usrphn);
                        },
                        controller: txt1,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                    ],
                    TextFormField(
                      //for userphone
                      keyboardType: TextInputType.phone,
                      focusNode: usrphn,
                      maxLength: 10,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        label: const Text(
                          "Mobile Number",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        prefixIcon: const Icon(
                          Icons.phone,
                        ),
                      ),

                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(pass);
                      },
                      controller: txt2,
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    TextFormField(
                      //for password
                      obscureText: !passwordVis,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.text,
                      focusNode: pass,
                      decoration: InputDecoration(
                        errorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(), //<-- SEE HERE
                          borderRadius: BorderRadius.circular(50.0),
                        ),
                        label: const Text(
                          "Password",
                          style: TextStyle(fontWeight: FontWeight.w500),
                        ),
                        prefixIcon: const Icon(
                          Icons.lock,
                        ),
                      ),
                      controller: txt3,
                      onFieldSubmitted: (_) {
                        FocusScope.of(context).requestFocus(but);
                        pwd = _;
                      },
                    ),
                    SizedBox(
                      height: height * 0.01,
                    ),
                    if (check == 0)
                      Container(
                        alignment: Alignment.centerRight,
                        margin: const EdgeInsets.all(3),
                        child: GestureDetector(
                          onTap: () {
                            final TextEditingController passwordController =
                                    TextEditingController(),
                                phoneController = TextEditingController();
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Container(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      const Text(
                                        'Change Password',
                                        style: TextStyle(
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 20.0),
                                      TextField(
                                        controller: phoneController,
                                        decoration: const InputDecoration(
                                          labelText: 'Existing Phone Number',
                                        ),
                                        obscureText: true,
                                        keyboardType: TextInputType.number,
                                      ),
                                      TextField(
                                        controller: passwordController,
                                        decoration: const InputDecoration(
                                          labelText: 'New Password',
                                        ),
                                        obscureText: true,
                                      ),
                                      const SizedBox(height: 20.0),
                                      ElevatedButton(
                                        onPressed: () async {
                                          if (passwordController.text == "") {
                                            return;
                                          }
                                          var res = await obj.resetPassword(
                                            passwordController.text,
                                            phoneController.text,
                                          );
                                          if (res == "Yes") {
                                            Navigator.pop(context);
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  "Password Changed Successfully!!!",
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: const Text('Submit'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: const Text(
                            "Forgot Password",
                            textAlign: TextAlign.end,
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                    Row(
                      //show password widget
                      children: [
                        Checkbox(
                            value: passwordVis,
                            onChanged: (val) {
                              setState(() {
                                passwordVis = !passwordVis;
                              });
                            }),
                        Text(
                          "Show Password",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: width * 0.035,
                          ),
                        ),
                      ],
                    ),
                    //form button
                    SizedBox(
                      width: width * 0.4,
                      child: ElevatedButton(
                        onPressed: () {
                          if (check == 1) {
                            saveSignup(context, obj);
                          } else {
                            saveLogin(context, obj);
                          }
                        },
                        focusNode: but,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // #b3f53b
                          elevation: 0,
                          padding: const EdgeInsets.all(10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          check == 0 ? "LOGIN" : "REGISTER",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                    if (check == 0)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.035,
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.035,
                                ),
                              ),
                              onTap: () => change(1),
                            )
                          ],
                        ),
                      ),
                    if (check != 0)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account? ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: width * 0.035,
                              ),
                            ),
                            GestureDetector(
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: width * 0.035,
                                ),
                              ),
                              onTap: () => change(0),
                            )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

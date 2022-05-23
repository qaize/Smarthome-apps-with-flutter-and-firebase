// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/screen/signup_screen.dart';
import 'package:firebase_signin/screen/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_signin/utils/color.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  DateTime timeBackPressed = DateTime.now();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final diffrence = DateTime.now().difference(timeBackPressed);
        final isWarning = diffrence >= Duration(seconds: 2);

        timeBackPressed = DateTime.now();

        if (isWarning) {
          const message = 'Press back again to exit app';
          Fluttertoast.showToast(msg: message);
          return false;
        } else {
          Fluttertoast.cancel();
          return true;
        }
      },
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            backgroundColor: primcolor,
            body: Container(
              padding: EdgeInsets.only(bottom: 10),
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height * 0.3,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            colors: [blue, blue2],
                            end: Alignment.bottomCenter,
                            begin: Alignment.topCenter),
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(100))),
                    child: Center(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/Splash.png',
                            width: 200,
                            height: 200,
                          ),
                          Text(
                            "Login page",
                            style: TextStyle(
                                fontSize: 30,
                                color: Color(0xff202227),
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.only(left: 20, right: 20, top: 30),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(
                            top: 20,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 5,
                              color: Colors.black.withOpacity(0.3),
                            ),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.only(left: 20),
                          child: Form(
                            key: _key,
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _email,
                                  validator: validateEmail,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Email",
                                      prefixIcon: Icon(Icons.email_rounded)),
                                ),
                                const Divider(
                                  color: Colors.black,
                                ),
                                TextFormField(
                                  controller: _password,
                                  validator: validatePassword,
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Password",
                                      prefixIcon: Icon(Icons.vpn_key)),
                                ),
                                Center(
                                    child: Text(
                                  errorMessage,
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 10),
                                )),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: InkWell(
                              onTap: () async {
                                if (_key.currentState!.validate()) {
                                  try {
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: _email.text,
                                            password: _password.text)
                                        .then((value) {
                                      Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Splash_Screen()));
                                    });
                                  } on FirebaseAuthException catch (error) {
                                    errorMessage = error.message!;
                                  }
                                  setState(() {});
                                }
                              },
                              radius: 50,
                              splashColor: Colors.lightBlue,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              child: Container(
                                margin: EdgeInsets.all(40),
                                width: double.infinity,
                                height: 35,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [blue, blue2],
                                        end: Alignment.centerLeft,
                                        begin: Alignment.centerRight),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: Text("Login",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.grey[200])),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RichText(
                                  text: TextSpan(children: [
                                TextSpan(
                                    text: "Dont have any account ?",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white)),
                              ])),
                              TextButton(
                                  onPressed: () {
                                    setState(() {});
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignupScreen()));
                                  },
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: blue),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    ),
                  ))
                ],
              ),
            ),
          )),
    );
  }
}

//Validator

String? validateEmail(String? formEmail) {
  if (formEmail == null || formEmail.isEmpty)
    return 'E-mail address is required.';

  String pattern = r'\w+@\w+\.\w+';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formEmail)) return 'Invalid E-mail Address format.';
  return null;
}

String? validatePassword(String? formPassword) {
  if (formPassword == null || formPassword.isEmpty)
    return 'Password is required.';

  String pattern = r'^.{6,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(formPassword))
    return '''
      Password must be at least 6 characters
      ''';
  return null;
}

// ignore_for_file: prefer_const_constructors, duplicate_ignore, curly_braces_in_flow_control_structures

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/screen/signin_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_signin/utils/color.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  String errorMessage = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: primcolor,
          body: SafeArea(
            child: Container(
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
                          // ignore: prefer_const_constructors
                          Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 30,
                                color: Colors.blueGrey,
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
                                width: 5, color: Colors.grey.withOpacity(0.8)),
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
                                        .createUserWithEmailAndPassword(
                                            email: _email.text,
                                            password: _password.text)
                                        .then((value) => showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AlertDialog(
                                                title: Text(
                                                    "Succesfully Registered"),
                                                content: Text(
                                                    "Back to Login Page ?"),
                                                actions: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {});
                                                        Navigator.pushReplacement(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        SignInScreen()));
                                                      },
                                                      child: Text("yes")),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        setState(() {});
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                      child: Text("no")),
                                                ],
                                              );
                                            }));
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
                                child: Text("Sign up",
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
                                  text: TextSpan(children: const [
                                TextSpan(
                                    text: "Already Have an Account ?",
                                    style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.white)),
                              ])),
                              TextButton(
                                  onPressed: () {
                                    setState(() {});
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SignInScreen()));
                                  },
                                  child: Text(
                                    "Login",
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
          ),
        ));
  }
}

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

  return null;
}

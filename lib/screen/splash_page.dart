import 'dart:async';
import 'package:firebase_signin/screen/home_screen.dart';
import 'package:firebase_signin/utils/color.dart';
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Splash_Screen extends StatefulWidget {
  const Splash_Screen({Key? key}) : super(key: key);

  @override
  _Splash_ScreenState createState() => _Splash_ScreenState();
}

class _Splash_ScreenState extends State<Splash_Screen> {
  @override
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primcolor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(),
              const CircularProgressIndicator(),
              const Text("Loging in...",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold)),
              Container()
            ],
          ),
        ),
      ),
    );
  }
}

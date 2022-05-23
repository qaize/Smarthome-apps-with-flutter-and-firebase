import 'package:flutter/material.dart';
import 'color.dart';
import 'package:provider/provider.dart';
import 'package:firebase_signin/utils/services.dart';
import 'dart:async';

//KY-026
Container KD = Container(
  height: 50,
  width: 150,
  decoration: BoxDecoration(
      color: Colors.red,
      border: Border.all(width: 4, color: Colors.white),
      borderRadius: BorderRadius.circular(20)),
  child: Center(
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text("Terdeteksi Api",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
      ],
    ),
  ),
);

Container KS = Container(
  height: 50,
  width: 150,
  decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [blue, blue2],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter),
      border: Border.all(width: 4, color: Colors.white),
      borderRadius: BorderRadius.circular(20)),
  child: Center(
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text("tidak ada api",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black.withOpacity(0.8),
            )),
      ],
    ),
  ),
);

//MQ-38
Container mcD = Container(
  height: 50,
  width: 150,
  decoration: BoxDecoration(
      color: Colors.red,
      border: Border.all(width: 4, color: Colors.white),
      borderRadius: BorderRadius.circular(20)),
  child: Center(
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text("TERBUKA!",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
      ],
    ),
  ),
);

Container mcS = Container(
  height: 50,
  width: 150,
  decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [blue, blue2],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter),
      border: Border.all(width: 4, color: Colors.white),
      borderRadius: BorderRadius.circular(20)),
  child: Center(
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text("Tertutup!",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black.withOpacity(0.8),
            )),
      ],
    ),
  ),
);

//Sensor PIR
Container pirD = Container(
  height: 50,
  width: 150,
  decoration: BoxDecoration(
      color: Colors.red,
      border: Border.all(width: 4, color: Colors.white),
      borderRadius: BorderRadius.circular(20)),
  child: Center(
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text("Motion!",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            )),
      ],
    ),
  ),
);

Container PirS = Container(
  height: 50,
  width: 150,
  decoration: BoxDecoration(
      gradient: LinearGradient(
          colors: [blue, blue2],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter),
      border: Border.all(width: 4, color: Colors.white),
      borderRadius: BorderRadius.circular(20)),
  child: Center(
    child: Column(
      children: [
        SizedBox(
          height: 8,
        ),
        Text("No Motion!",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black.withOpacity(0.8),
            )),
      ],
    ),
  ),
);

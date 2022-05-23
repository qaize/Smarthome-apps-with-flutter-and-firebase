import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_signin/data/dataSensor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class firebase_service {
  //update nilai lampu dapur
  lampuDapur(bool state) async {
    var db =
        FirebaseFirestore.instance.collection(CollectionSensor.sensorDapur);
    Map<String, bool> _dataku = {
      DevicesDapur.lampuDapur: state,
    };

    db.doc("dapur").update(_dataku);
  }

  //update kipas
  kipasDapur(bool state) async {
    var db =
        FirebaseFirestore.instance.collection(CollectionSensor.sensorDapur);
    Map<String, bool> _dataku = {
      DevicesDapur.kipas: state,
    };

    db.doc("dapur").update(_dataku);
  }

  //update nilai lampu kamar
  lampukamar(bool state) async {
    var db =
        FirebaseFirestore.instance.collection(CollectionSensor.sensorKamar);
    Map<String, bool> _dataku = {
      DevicesKamar.lampuKamar: state,
    };

    db.doc("kamartidur").update(_dataku);
  }

  //update nilai lampu RT
  lampurt(bool state) async {
    var db =
        FirebaseFirestore.instance.collection(CollectionSensor.sensorRTamu);
    Map<String, bool> _dataku = {
      DevicesRuangTamu.lampu: state,
    };

    db.doc("ruangan").update(_dataku);
  }

  //update nilai lampu teras
  lamputeras(bool state) async {
    var db =
        FirebaseFirestore.instance.collection(CollectionSensor.sensorTeras);
    Map<String, bool> _dataku = {
      DevicesTeras.lampuTeras: state,
    };

    db.doc("terasControl").update(_dataku);
  }

  //update nilai lagi dirumah atao ndak
  iamhome(bool state) async {
    var db =
        FirebaseFirestore.instance.collection(CollectionSensor.sensorRTamu);
    Map<String, bool> _dataku = {
      "iamhome": state,
    };

    db.doc("ruangan").update(_dataku);
  }
}

class NotificationService extends ChangeNotifier {
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  //initilize

  Future initialize() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();

    AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("ic_launcher");

    IOSInitializationSettings iosInitializationSettings =
        IOSInitializationSettings();

    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: androidInitializationSettings,
            iOS: iosInitializationSettings);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //Instant Notifications
  Future instantNofitication() async {
    var android = AndroidNotificationDetails("id", "channel");
    var platform = new NotificationDetails(android: android);

    await _flutterLocalNotificationsPlugin.show(
        0, "Perhatian", "Terdeteksi sesuatu mencurigakan", platform,
        payload: "Welcome to demo app");
  }

  //Cancel notification

  Future cancelNotification() async {
    await _flutterLocalNotificationsPlugin.cancelAll();
  }
}

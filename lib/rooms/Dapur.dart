// ignore_for_file: prefer_const_constructors, file_names
import 'dart:ui';

import 'package:firebase_signin/utils/color.dart';
import 'package:firebase_signin/utils/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_signin/data/dataSensor.dart';
import 'package:flutter_switch/flutter_switch.dart';

class RDapur extends StatefulWidget {
  const RDapur({Key? key}) : super(key: key);

  @override
  _RDapurState createState() => _RDapurState();
}

class _RDapurState extends State<RDapur> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection(CollectionSensor.sensorDapur)
      .snapshots();

  bool dapur = false;
  bool kipas = false;
  final double _min = 0;
  final double _max = 10000;
  double Gasvalue = 0;

  var aman = Text(
    "Aman",
    style: TextStyle(color: Colors.green, fontSize: 30),
  );
  var bahaya = Text(
    "Bahaya",
    style: TextStyle(color: Colors.red, fontSize: 30),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primcolor,
      body: SafeArea(
        child: StreamBuilder(
          stream: _usersStream,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("something is wrong");
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return SafeArea(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (__, index) {
                  return Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.10,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                colors: [blue, blue2],
                                end: Alignment.bottomCenter,
                                begin: Alignment.topCenter),
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(80),
                                bottomRight: Radius.circular(80))),
                        child: Center(
                            child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.02,
                            ),
                            Text(
                              "Dapur",
                              style: TextStyle(
                                  fontSize: 40,
                                  color: Colors.black.withOpacity(0.7)),
                            )
                          ],
                        )),
                      ),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(height: 50),
                            //switch dapur
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text('Kondisi Lampu ',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30)),
                                    SizedBox(height: 10),
                                    snapshot.data!.docChanges[index]
                                                .doc[DevicesDapur.lampuDapur] ==
                                            true
                                        ? on
                                        : off,
                                  ],
                                ),
                                Divider(),
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    FlutterSwitch(
                                        showOnOff: true,
                                        toggleSize: 30,
                                        valueFontSize: 30,
                                        width: 100,
                                        height: 75,
                                        activeColor: Colors.green,
                                        inactiveColor: Colors.red,
                                        value: dapur = snapshot
                                            .data!
                                            .docChanges[index]
                                            .doc[DevicesDapur.lampuDapur],
                                        onToggle: (value) {
                                          setState(() {
                                            dapur = value;
                                            firebase_service()
                                                .lampuDapur(dapur);
                                          });
                                        }),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 50),
                            //switch dapur
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Column(
                                  children: [
                                    Text('Kondisi Kipas ',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 30)),
                                    SizedBox(height: 10),
                                    snapshot.data!.docChanges[index]
                                                .doc[DevicesDapur.kipas] ==
                                            true
                                        ? on
                                        : off,
                                  ],
                                ),
                                Divider(),
                                Column(
                                  children: [
                                    SizedBox(height: 10),
                                    FlutterSwitch(
                                        showOnOff: true,
                                        toggleSize: 30,
                                        valueFontSize: 30,
                                        width: 100,
                                        height: 75,
                                        activeColor: Colors.green,
                                        inactiveColor: Colors.red,
                                        value: kipas = snapshot
                                            .data!
                                            .docChanges[index]
                                            .doc[DevicesDapur.kipas],
                                        onToggle: (value) {
                                          setState(() {
                                            kipas = value;
                                            firebase_service()
                                                .kipasDapur(kipas);
                                          });
                                        }),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  "Kadar Gas",
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                                Text("       :")
                              ],
                            ),
                            Column(
                              children: [
                                RotatedBox(
                                    quarterTurns: 4,
                                    child: Slider(
                                      min: _min,
                                      max: _max,
                                      value: Gasvalue = double.parse(snapshot
                                          .data!
                                          .docChanges[index]
                                          .doc[DevicesDapur.gasDapur]),
                                      onChanged: (double value) => setState(() {
                                        Gasvalue = value;
                                      }),
                                    )),
                                Text(
                                  '${Gasvalue.toDouble()}' + (' ppm'),
                                  style: TextStyle(
                                      fontSize: 30, color: Colors.white),
                                ),
                                Gasvalue >= 2000 ? bahaya : aman
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}

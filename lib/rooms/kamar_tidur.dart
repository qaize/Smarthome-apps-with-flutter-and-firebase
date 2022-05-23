// ignore_for_file: prefer_const_constructors, file_names
import 'dart:ui';

import 'package:firebase_signin/utils/services.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_signin/data/dataSensor.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:firebase_signin/utils/color.dart';

class KamarTidur extends StatefulWidget {
  const KamarTidur({Key? key}) : super(key: key);

  @override
  _KamarTidurState createState() => _KamarTidurState();
}

class _KamarTidurState extends State<KamarTidur> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection(CollectionSensor.sensorKamar)
      .snapshots();

  bool _kamar = false;

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
                              "Kamar",
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
                                                .doc[DevicesKamar.lampuKamar] ==
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
                                        value: _kamar = snapshot
                                            .data!
                                            .docChanges[index]
                                            .doc[DevicesKamar.lampuKamar],
                                        onToggle: (value) {
                                          setState(() {
                                            _kamar = value;
                                            firebase_service()
                                                .lampukamar(_kamar);
                                          });
                                        }),
                                  ],
                                ),
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

// ignore_for_file: prefer_const_constructors
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_signin/rooms/Dapur.dart';
import 'package:firebase_signin/rooms/teras.dart';
import 'package:firebase_signin/rooms/kamar_tidur.dart';
import 'package:firebase_signin/rooms/ruang_keluarga.dart';
import 'package:firebase_signin/screen/signin_screen.dart';
import 'package:firebase_signin/utils/container.dart';
import 'package:firebase_signin/utils/services.dart';
import 'package:firebase_signin/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:weather_icons/weather_icons.dart';
import 'dart:async';
import 'package:firebase_signin/data/dataSensor.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void initState() {
    super.initState();
    Provider.of<NotificationService>(context, listen: false).initialize();
  }

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance
      .collection(CollectionSensor.sensorRTamu)
      .snapshots();
  bool tadaima = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: primcolor,
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: blue,
        //   child: Icon(Icons.gps_fixed_outlined),
        //   onPressed: () {
        //     Timer(const Duration(milliseconds: 1000), () {
        //       NotificationService().instantNofitication();
        //     });
        //   },
        // ),
        body: SafeArea(
          child: StreamBuilder<QuerySnapshot>(
              stream: _usersStream,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("something is wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (__, index) {
                      return Column(
                        children: [
                          Stack(
                            children: [
                              Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                        colors: [blue, blue2],
                                        end: Alignment.bottomCenter,
                                        begin: Alignment.topCenter),
                                    borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(80),
                                        bottomRight: Radius.circular(80))),
                              ),
                              Container(
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                width: 413,
                                height: 106,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ClipRRect(
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            border: Border.all(
                                                color: Colors.white, width: 5),
                                            image: DecorationImage(
                                              fit: BoxFit.cover,
                                              alignment: Alignment.center,
                                              image: NetworkImage(
                                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7c/User_font_awesome.svg/2048px-User_font_awesome.svg.png"),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(
                                          left: 2, right: 15, top: 37),
                                      child: Column(
                                        children: [
                                          Text("Smart Home",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'SF Rounded',
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold)),
                                          Text("Logged in",
                                              style: TextStyle(
                                                color: Colors.black
                                                    .withOpacity(0.9),
                                                fontFamily: 'SF Rounded',
                                                fontSize: 12,
                                              )),
                                        ],
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        FirebaseAuth.instance
                                            .signOut()
                                            .then((value) => showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    elevation: 24,
                                                    title: Text(
                                                      "Want to Logout ?",
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    backgroundColor: primcolor,
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
                                                          child: Text("YES")),
                                                      ElevatedButton(
                                                          onPressed: () {
                                                            setState(() {});
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                          child: Text("NO")),
                                                    ],
                                                  );
                                                }));
                                      },
                                      icon: Icon(Icons.logout_rounded),
                                      color: Colors.white.withRed(200),
                                      iconSize: 40,
                                    ),

                                    //card--------------------------------------------------------------------------
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Column(
                            children: [
                              SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // sensor api
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              children: [
                                                Text("Kondisi Sensor Api :",
                                                    style: TextStyle(
                                                        color: Colors.white
                                                            .withOpacity(0.8),
                                                        fontSize: 20)),
                                                SizedBox(
                                                  height: 15,
                                                ),
                                                snapshot.data!.docChanges[index]
                                                                .doc[
                                                            DevicesRuangTamu
                                                                .api] ==
                                                        true
                                                    ? KD
                                                    : KS,
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),

                                    //----------------------------------------------------------------------------
                                    SizedBox(
                                      height: 15,
                                    ),
                                    //------------------------menu------------------------------------------------
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          splashColor: Color(0xff00e676),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RDapur()));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                gradient: LinearGradient(
                                                    colors: [blue, blue2],
                                                    end: Alignment.bottomCenter,
                                                    begin: Alignment.topCenter),
                                                border: Border.all(
                                                    color: Colors.blueGrey,
                                                    width: 5)),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Icon(
                                                    Icons.kitchen_outlined,
                                                    color: Colors.blueGrey,
                                                    size: 70,
                                                  ),
                                                  Text("Dapur",
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          fontSize: 30)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Color(0xff00e676),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        RuangKeluarga()));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black,
                                                border: Border.all(
                                                    color: Colors.white
                                                        .withRed(200),
                                                    width: 5)),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Icon(
                                                    Icons.tv_outlined,
                                                    color: Colors.lightBlue,
                                                    size: 70,
                                                  ),
                                                  Text("Ruang Tamu",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 20)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        InkWell(
                                          splashColor: Color(0xff00e676),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        KamarTidur()));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                color: Colors.black,
                                                border: Border.all(
                                                    color: Colors.white
                                                        .withRed(200),
                                                    width: 5)),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Icon(
                                                    Icons.bed_outlined,
                                                    color: Colors.blue,
                                                    size: 75,
                                                  ),
                                                  Text("Kamar",
                                                      style: TextStyle(
                                                          color: Colors.white
                                                              .withOpacity(0.7),
                                                          fontSize: 30)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          splashColor: Color(0xff00e676),
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Teras()));
                                          },
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            height: 150,
                                            width: 150,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                gradient: LinearGradient(
                                                    colors: [blue, blue2],
                                                    end: Alignment.bottomCenter,
                                                    begin: Alignment.topCenter),
                                                border: Border.all(
                                                    color: Colors.blueGrey,
                                                    width: 5)),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Icon(
                                                    Icons.recent_actors_rounded,
                                                    color: Colors.blueGrey,
                                                    size: 75,
                                                  ),
                                                  Text("Teras",
                                                      style: TextStyle(
                                                          color: Colors.black
                                                              .withOpacity(0.7),
                                                          fontSize: 30)),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Column(
                                      children: [
                                        Center(
                                          child: Container(
                                            height: 50,
                                            width: 200,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [blue, blue2],
                                                    end: Alignment.bottomCenter,
                                                    begin: Alignment.topCenter),
                                                border: Border.all(
                                                    width: 4,
                                                    color: Colors.blueGrey),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: Center(
                                              child: Column(
                                                children: [
                                                  SizedBox(
                                                    height: 8,
                                                  ),
                                                  Text(
                                                    '${snapshot.data!.docChanges[index].doc[DevicesRuangTamu.state]}',
                                                    style: TextStyle(
                                                        color: Colors.black
                                                            .withOpacity(0.7),
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Center(
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 25,
                                              ),
                                              Consumer<NotificationService>(
                                                builder: (context, model, _) =>
                                                    Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                      ElevatedButton(
                                                          onPressed: () => model
                                                              .instantNofitication(),
                                                          child: Text(
                                                              'Instant Notification')),
                                                    ]),
                                              ),
                                              FlutterSwitch(
                                                  showOnOff: true,
                                                  activeColor: blue,
                                                  inactiveColor: primcolor,
                                                  value: tadaima = snapshot
                                                          .data!
                                                          .docChanges[index]
                                                          .doc[
                                                      DevicesRuangTamu.iamhere],
                                                  onToggle: (value) {
                                                    setState(() {
                                                      tadaima = value;
                                                      firebase_service()
                                                          .iamhome(tadaima);
                                                    });
                                                  }),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    });
              }),
        ),
      ),
    );
  }
}

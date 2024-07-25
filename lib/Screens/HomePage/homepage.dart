import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lora_chatapp/Assets/Code/chatTemplate.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Database/database.dart';
import 'package:lora_chatapp/Screens/Arduino%20Chat%20Page/bluetooth_list_devices.dart';

import '../../Database/hiveDatabase.dart';
import '../../Helper Function/getLocation.dart';

Future<Position?> getCurrentLocation() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled, don't continue
    return null;
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, don't continue
      return null;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately
    return null;
  }

  Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high);

  return position;
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String errorMessage = "";

  @override
  void initState() {
    super.initState();
    _initializeLocation();
  }

  Future<String> getUserId() async {
    var email = FirebaseAuth.instance.currentUser?.email;
    var users = await FirebaseFirestore.instance
        .collection('users')
        .where('email', isEqualTo: email)
        .get();

    for (var doc in users.docs) {
      userdb.userData = doc.data();
    }

    return userdb.userData['userid'];
  }

  Future<void> _initializeLocation() async {
    getUserId();
    Position? position = await getCurrentLocation();
    if (position != null) {
      setState(() {
        longitude = position.longitude.toString();
        latitude = position.latitude.toString();
      });
    } else {
      setState(() {
        errorMessage = "Failed to get location.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyFont(
                  text: "D A S H B O A R D",
                  size: 25,
                  weight: FontWeight.w600,
                  color: Colors.black),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  children: [
                    CircleAvatar(
                      child:
                          Image.asset("lib/Assets/Images/profile-picture.png"),
                      radius: 40,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        MyFont(
                            text: userdb.userData['name'],
                            size: 18,
                            weight: FontWeight.w600,
                            color: Colors.black),
                        MyFont(
                            text: '@' + userdb.userData['userid'],
                            size: 16,
                            weight: FontWeight.w500,
                            color: Colors.black45),
                        SizedBox(
                          height: 10,
                        ),
                        MyFont(
                            text: "Longitude: $longitude",
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black),
                        MyFont(
                            text: 'Latitude: $latitude',
                            size: 16,
                            weight: FontWeight.w400,
                            color: Colors.black),
                      ],
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              MyFont(
                  text: "Having an emergency?",
                  size: 20,
                  weight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 10,
              ),
              MaterialButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BluetoothDeviceListPage()),
                  );
                },
                child: Row(
                  children: [
                    Icon(
                      CupertinoIcons.exclamationmark_bubble_fill,
                      color: Colors.white,
                      size: 45,
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    MyFont(
                        text: "E M E R G E N C Y",
                        size: 25,
                        weight: FontWeight.w900,
                        color: Colors.white)
                  ],
                ),
                color: Colors.black38,
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                height: 80,
              ),
              SizedBox(
                height: 20,
              ),
              MyFont(
                  text: "Nearby Organizations/NGOs",
                  size: 20,
                  weight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 10,
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatTemplate(
                              path: "lib/Assets/Images/TamilNadu_Logo.svg.png",
                              title: "State Disaster Management Authority",
                              chat: db.chatMessagesSDMA);
                        }));
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Image.asset(
                                "lib/Assets/Images/TamilNadu_Logo.svg.png",
                              ),
                              radius: 35,
                              backgroundColor: Colors.white,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                "State Disaster Management Authority",
                                style: TextStyle(
                                  fontSize: 15.5,
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Image.asset(
                              "lib/Assets/Images/National_Disaster_Management_Authority_Logo.png",
                            ),
                            radius: 35,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "National Disaster Management Authority",
                              style: TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            child: Image.asset(
                              "lib/Assets/Images/National_Disaster_Response_Force_Logo.png",
                            ),
                            radius: 35,
                            backgroundColor: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Text(
                              "National Disaster Response Force",
                              style: TextStyle(
                                fontSize: 15.5,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

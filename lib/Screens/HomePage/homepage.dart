import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Database/database.dart';

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
  String longitude = "";
  String latitude = "";
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
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyFont(
                  text: "H O M E P A G E",
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
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          child: Container(
                            height: 420,
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(CupertinoIcons
                                        .exclamationmark_triangle_fill),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    MyFont(
                                        text: "A L E R T",
                                        size: 20,
                                        weight: FontWeight.w500,
                                        color: Colors.black),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                MyFont(
                                    text:
                                        "This will send a SOS signal and your user information to all the nearby organizations which will include:",
                                    size: 16,
                                    weight: FontWeight.w400,
                                    color: Colors.black),
                                SizedBox(
                                  height: 10,
                                ),
                                MyFont(
                                    text: "1. Your name",
                                    size: 16,
                                    weight: FontWeight.w500,
                                    color: Colors.black),
                                MyFont(
                                    text: "2. Your age",
                                    size: 16,
                                    weight: FontWeight.w500,
                                    color: Colors.black),
                                MyFont(
                                    text: "3. Your contact",
                                    size: 16,
                                    weight: FontWeight.w500,
                                    color: Colors.black),
                                MyFont(
                                    text: "4. Your current location",
                                    size: 16,
                                    weight: FontWeight.w500,
                                    color: Colors.black),
                                SizedBox(
                                  height: 20,
                                ),
                                MyFont(
                                    text: "Are you sure you want to continue?",
                                    size: 17,
                                    weight: FontWeight.w500,
                                    color: Colors.black),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text("Cancel"),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide()),
                                      color: Colors.white,
                                    ),
                                    SizedBox(
                                      width: 15,
                                    ),
                                    MaterialButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(SnackBar(
                                                content: Text(
                                                    "SOS sent successfully")));
                                      },
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: BorderSide()),
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      });
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
                        text: "S E N D   S O S",
                        size: 30,
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

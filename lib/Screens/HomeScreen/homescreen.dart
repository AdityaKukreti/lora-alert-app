import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/Code/cards.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Assets/Code/selectButton.dart';
import 'package:lora_chatapp/Screens/HomeScreen/drawer.dart';

import '../../Database/database.dart';
import '../../Database/hiveDatabase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<bool> selected = [true, false, false];
  Map<String, bool> statesAndUTs = {
    "All": true,
    "Andaman and Nicobar Islands": false,
    "Andhra Pradesh": false,
    "Arunachal Pradesh": false,
    "Assam": false,
    "Bihar": false,
    "Chandigarh": false,
    "Chhattisgarh": false,
    "Dadra and Nagar Haveli and Daman and Diu": false,
    "Delhi": false,
    "Goa": false,
    "Gujarat": false,
    "Haryana": false,
    "Himachal Pradesh": false,
    "Jammu and Kashmir": false,
    "Jharkhand": false,
    "Karnataka": false,
    "Kerala": false,
    "Ladakh": false,
    "Lakshadweep": false,
    "Madhya Pradesh": false,
    "Maharashtra": false,
    "Manipur": false,
    "Meghalaya": false,
    "Mizoram": false,
    "Nagaland": false,
    "Odisha": false,
    "Puducherry": false,
    "Punjab": false,
    "Rajasthan": false,
    "Sikkim": false,
    "Tamil Nadu": false,
    "Telangana": false,
    "Tripura": false,
    "Uttar Pradesh": false,
    "Uttarakhand": false,
    "West Bengal": false
  };
  Map<String, bool> naturalDisasters = {
    "All": true,
    "Avalanche": false,
    "Blizzard": false,
    "Cyclone": false,
    "Drought": false,
    "Earthquake": false,
    "Flood": false,
    "Hurricane": false,
    "Landslide": false,
    "Meteor Strike": false,
    "Pandemic": false,
    "Sandstorm": false,
    "Tornado": false,
    "Tsunami": false,
    "Volcanic Eruption": false,
    "Wildfire": false
  };

  var state = "All";
  var type = "All";
  final FirestoreDatabase database = FirestoreDatabase();

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

  Future<void> loadUserid() async {
    db.userid = await getUserId();
    db.updateDataBase();
  }

  @override
  void initState() {
    db.loadData();
    loadUserid();

    super.initState();
  }

  String formatTime(DateTime time) {
    return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: MyFont(
            text: "A L E R T S",
            size: 25,
            weight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 26, vertical: 5),
        child: Center(
          child: Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        setState(() {
                          selected = [true, false, false];
                          statesAndUTs.forEach((key, value) {
                            statesAndUTs[key] = key == "All";
                          });
                          naturalDisasters.forEach((key, value) {
                            naturalDisasters[key] = key == "All";
                          });
                          state = "All";
                          type = "All";
                        });
                      },
                      style: ButtonStyle(
                        side: MaterialStateProperty.all(BorderSide(
                            color:
                                selected[0] ? Colors.transparent : Colors.black,
                            width: 1)),
                        backgroundColor: MaterialStateProperty.all(
                            selected[0] ? Colors.black : Colors.transparent),
                      ),
                      child: MyFont(
                        text: "All",
                        color: selected[0] ? Colors.white : Colors.black,
                        weight: FontWeight.w500,
                        size: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 20),
                                  width: double.maxFinite,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyFont(
                                          text: "Select a state",
                                          size: 22,
                                          weight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 20),
                                        Wrap(
                                          spacing: 8.0,
                                          children:
                                              statesAndUTs.keys.map((name) {
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: SelectButton(
                                                state: name,
                                                selected:
                                                    statesAndUTs[name] as bool,
                                                onTap: () {
                                                  setState(() {
                                                    if (name == "All") {
                                                      statesAndUTs.forEach(
                                                          (key, value) {
                                                        statesAndUTs[key] =
                                                            key == "All";
                                                      });
                                                    } else {
                                                      statesAndUTs["All"] =
                                                          false;
                                                      statesAndUTs.forEach(
                                                          (key, value) {
                                                        statesAndUTs[key] =
                                                            key == name;
                                                      });
                                                    }
                                                    state = name;
                                                    selected = [
                                                      false,
                                                      true,
                                                      selected[2]
                                                    ];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                              color: selected[1]
                                  ? Colors.transparent
                                  : Colors.black,
                              width: 1)),
                          backgroundColor: MaterialStateProperty.all(
                              selected[1] ? Colors.black : Colors.transparent)),
                      child: MyFont(
                        text: "State : $state",
                        color: selected[1] ? Colors.white : Colors.black,
                        weight: FontWeight.w500,
                        size: 15,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    TextButton(
                      onPressed: () async {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return Dialog(
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 30, horizontal: 20),
                                  width: double.maxFinite,
                                  child: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        MyFont(
                                          text: "Select a disaster",
                                          size: 22,
                                          weight: FontWeight.w500,
                                          color: Colors.black,
                                        ),
                                        SizedBox(height: 20),
                                        Wrap(
                                          spacing: 8.0,
                                          children:
                                              naturalDisasters.keys.map((name) {
                                            return Container(
                                              margin:
                                                  EdgeInsets.only(bottom: 5),
                                              child: SelectButton(
                                                state: name,
                                                selected: naturalDisasters[name]
                                                    as bool,
                                                onTap: () {
                                                  setState(() {
                                                    if (name == "All") {
                                                      naturalDisasters.forEach(
                                                          (key, value) {
                                                        naturalDisasters[key] =
                                                            key == "All";
                                                      });
                                                    } else {
                                                      naturalDisasters["All"] =
                                                          false;
                                                      naturalDisasters.forEach(
                                                          (key, value) {
                                                        naturalDisasters[key] =
                                                            key == name;
                                                      });
                                                    }
                                                    type = name;
                                                    selected = [
                                                      false,
                                                      selected[1],
                                                      true
                                                    ];
                                                  });
                                                  Navigator.pop(context);
                                                },
                                              ),
                                            );
                                          }).toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                      style: ButtonStyle(
                          side: MaterialStateProperty.all(BorderSide(
                              color: selected[2]
                                  ? Colors.transparent
                                  : Colors.black,
                              width: 1)),
                          backgroundColor: MaterialStateProperty.all(
                              selected[2] ? Colors.black : Colors.transparent)),
                      child: MyFont(
                        text: "Type : $type",
                        color: selected[2] ? Colors.white : Colors.black,
                        weight: FontWeight.w500,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder(
                stream: database.getPostStream(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text("No posts... Post something!"),
                      ),
                    );
                  }

                  var posts = snapshot.data!.docs;
                  var filteredPosts = posts.where((post) {
                    var postState = post["state"] ?? "Unknown";
                    var postType = post["type"] ?? "Unknown";

                    bool matchesState = (state == "All" || postState == state);
                    bool matchesType = (type == "All" || postType == type);

                    return matchesState && matchesType;
                  }).toList();

                  if (filteredPosts.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.all(25),
                        child: Text("No matching posts found."),
                      ),
                    );
                  }

                  return Expanded(
                    child: ListView.builder(
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        var post = filteredPosts[index];
                        print(post.id);

                        return FutureBuilder<QuerySnapshot>(
                          future: post.reference
                              .collection("comments")
                              .get(), // Fetch comments
                          builder: (context, commentSnapshot) {
                            if (commentSnapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }

                            var comments = commentSnapshot.data?.docs ?? [];

                            return MyCard(
                              docId: post.id,
                              fullname: post["username"],
                              username: post["userid"],
                              title: post["title"],
                              time: post[
                                  "time"], // Ensure this is correctly formatted elsewhere
                              post: post["content"],
                              commentCount: post["commentCount"],
                              comments: comments, // Pass comments to the card
                            );
                          },
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

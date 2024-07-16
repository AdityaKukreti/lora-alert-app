import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/cards.dart';
import 'package:lora_chatapp/Assets/font.dart';
import 'package:lora_chatapp/Assets/selectButton.dart';
import 'package:lora_chatapp/Screens/HomeScreen/drawer.dart';

import '../../Data Structures/postStructure.dart';

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
              Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    bool showPost = false;

                    if (selected[0] || (state == "All" && type == "All")) {
                      showPost = true;
                    } else if (state == "All" && type == posts[index].type) {
                      showPost = true;
                    } else if (type == "All" && state == posts[index].state) {
                      showPost = true;
                    } else if (state == posts[index].state &&
                        type == posts[index].type) {
                      showPost = true;
                    }

                    if (showPost) {
                      return MyCard(
                        fullname: posts[index].username,
                        username: posts[index].userid,
                        title: posts[index].title,
                        time: formatTime(posts[index].time),
                        post: posts[index].content,
                        commentCount: posts[index].commentCount,
                        comments: posts[index].comments,
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

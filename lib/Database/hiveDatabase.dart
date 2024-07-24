import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class HiveDataBase {
  var userid;
  List<dynamic> chatMessages = [
    BubbleSpecialThree(
      text: "Hi, I am Pluto, your AI assistant. How can i help you?",
      color: Colors.black,
      tail: false,
      isSender: false,
      textStyle: TextStyle(color: Colors.white),
    ),
  ];

  final _myBox = Hive.box('mybox');

  void loadData() {
    userid = _myBox.get("userid");
    userid = (userid == Null || userid == null) ? "" : userid;
  }

  void updateDataBase() {
    _myBox.put("userid", userid);
  }
}

HiveDataBase db = HiveDataBase();

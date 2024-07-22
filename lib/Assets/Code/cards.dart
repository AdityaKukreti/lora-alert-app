import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Helper%20Function/timeformatter.dart';

import '../../Screens/Post/post.dart';
import 'font.dart';

class MyCard extends StatefulWidget {
  const MyCard(
      {super.key,
      required this.fullname,
      required this.username,
      required this.time,
      required this.post,
      required this.title,
      required this.commentCount,
      required this.comments,
      required this.docId});
  final String docId;
  final String fullname;
  final String username;
  final String title;
  final Timestamp time;
  final String post;
  final int commentCount;
  final List<dynamic> comments;

  @override
  State<MyCard> createState() => _MyCardState();
}

class _MyCardState extends State<MyCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10, top: 10),
      padding: EdgeInsets.all(15),
      width: double.maxFinite,
      // height: 125,
      decoration: BoxDecoration(
        border: Border.all(width: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Post(
              fullname: widget.fullname,
              username: widget.username,
              time: widget.time,
              post: widget.post,
              title: widget.title,
              comments: widget.comments,
              docId: widget.docId,
            );
          }));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MyFont(
                text: widget.fullname,
                size: 14,
                weight: FontWeight.w600,
                color: Colors.black),
            Row(
              children: [
                MyFont(
                    text: "@${widget.username}",
                    size: 13,
                    weight: FontWeight.w500,
                    color: Colors.black54),
                SizedBox(
                  width: 5,
                ),
                Icon(
                  Icons.circle,
                  size: 5,
                  color: Colors.black54,
                ),
                SizedBox(
                  width: 5,
                ),
                MyFont(
                    text: formatTimestamp(widget.time),
                    size: 13,
                    weight: FontWeight.w500,
                    color: Colors.black54),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            MyFont(
                text: widget.title,
                size: 18,
                weight: FontWeight.w500,
                color: Colors.black),
            SizedBox(
              height: 10,
            ),
            MyFont(
                text: widget.post.length > 110
                    ? widget.post.substring(0, 110) + ' ...'
                    : widget.post,
                size: 14,
                weight: FontWeight.w400,
                color: Colors.black),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Icon(
                  Icons.message_outlined,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                MyFont(
                    text: widget.commentCount.toString() + " comments",
                    size: 14,
                    weight: FontWeight.w400,
                    color: Colors.black)
              ],
            )
          ],
        ),
      ),
    );
  }
}

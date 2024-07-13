import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/comment.dart';
import 'package:lora_chatapp/Assets/font.dart';

import '../../Data Structures/postStructure.dart';

class Post extends StatefulWidget {
  const Post(
      {super.key,
      required this.fullname,
      required this.username,
      required this.time,
      required this.post,
      required this.title,
      required this.comments});
  final String fullname;
  final String username;
  final String title;
  final String time;
  final String post;
  final List<CommentStructure> comments;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController commentController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyFont(
          text: "P O S T",
          size: 25,
          color: Colors.black,
          weight: FontWeight.w600,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          margin: EdgeInsets.only(bottom: 10, top: 10),
          padding: EdgeInsets.all(15),
          width: double.maxFinite,
          // height: 125,
          decoration: BoxDecoration(
            border: Border.all(width: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
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
                      text: widget.time,
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
                  text: widget.post,
                  size: 14,
                  weight: FontWeight.w400,
                  color: Colors.black),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 20,
              ),
              Divider(
                height: 1,
              ),
              SizedBox(
                height: 20,
              ),
              MyFont(
                  text: "Comments",
                  size: 20,
                  weight: FontWeight.w500,
                  color: Colors.black),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Icon(CupertinoIcons.pen),
                    TextField(
                      minLines: 1,
                      maxLines: 3,
                      // maxLength: 150,
                      decoration: InputDecoration(
                          hintText: "Write comment here...",
                          border:
                              OutlineInputBorder(borderSide: BorderSide.none),
                          constraints:
                              BoxConstraints(minWidth: 189, maxWidth: 189)),
                    ),
                    TextButton(
                      onPressed: () {},
                      style: ButtonStyle(
                          backgroundColor:
                              WidgetStateProperty.all(Colors.black)),
                      child: MyFont(
                        text: "Post",
                        color: Colors.white,
                        weight: FontWeight.w500,
                        size: 15,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.comments.length,
                  itemBuilder: (context, index) {
                    return Comment(
                        username: widget.comments[index].userid,
                        comment: widget.comments[index].comment,
                        time: "${widget.comments[index].time.hour}:" +
                            (widget.comments[index].time.minute
                                        .toString()
                                        .length <
                                    2
                                ? "00"
                                : widget.comments[index].time.minute
                                    .toString()));
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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/Code/comment.dart';
import 'package:lora_chatapp/Database/database.dart';

import '../../Assets/Code/font.dart';
import '../../Database/hiveDatabase.dart';
import '../../Helper Function/timeformatter.dart';

class Post extends StatefulWidget {
  const Post(
      {super.key,
      required this.fullname,
      required this.username,
      required this.time,
      required this.post,
      required this.title,
      required this.comments,
      required this.docId});
  final String docId;
  final String fullname;
  final String username;
  final String title;
  final Timestamp time;
  final String post;
  final List<dynamic> comments;

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  TextEditingController commentController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    print(widget.docId);
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
                      controller: commentController,
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
                      onPressed: () async {
                        if (commentController.text.isNotEmpty) {
                          FirebaseFirestore.instance
                              .runTransaction((transaction) async {
                            DocumentReference commentRef = FirebaseFirestore
                                .instance
                                .collection('posts')
                                .doc(widget.docId)
                                .collection("comments")
                                .doc();

                            DocumentReference postRef = FirebaseFirestore
                                .instance
                                .collection('posts')
                                .doc(widget.docId);

                            DocumentSnapshot postSnapshot =
                                await transaction.get(postRef);
                            int newCommentCount =
                                postSnapshot.get('commentCount') + 1;

                            transaction.set(commentRef, {
                              "comment": commentController.text,
                              "time": Timestamp.now(),
                              "userid": db.userid
                            });

                            transaction.update(
                                postRef, {"commentCount": newCommentCount});
                          }).then((result) {
                            commentController.clear();
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Comment posted")));
                          }).catchError((error) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content:
                                    Text("Failed to post comment: $error")));
                          });
                        }
                      },
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
              StreamBuilder(
                  stream: FirestoreDatabase().getCommentStream(widget.docId),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.all(25),
                          child:
                              Text("No comments, be the first one to comment!"),
                        ),
                      );
                    }

                    var posts = snapshot.data!.docs;
                    return Expanded(
                        child: ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return Comment(
                            username: posts[index]['userid'],
                            comment: posts[index]['comment'],
                            time: formatTimestamp(posts[index]['time']));
                      },
                    ));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

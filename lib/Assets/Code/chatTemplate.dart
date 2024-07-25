import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/Code/chatTextField.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';

class ChatTemplate extends StatefulWidget {
  const ChatTemplate(
      {super.key, required this.path, required this.title, required this.chat});
  final String path;
  final String title;
  final List<Map<String, dynamic>> chat;
  @override
  State<ChatTemplate> createState() => _ChatTemplateState();
}

class _ChatTemplateState extends State<ChatTemplate> {
  TextEditingController messageController = TextEditingController();

  Widget customBubble(List<Widget> texts) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        width: MediaQuery.of(context).size.width * .7,
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        margin: EdgeInsets.fromLTRB(17, 7, 7, 7),
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(10)),
        constraints: BoxConstraints(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisAlignment: MainAxisAlignment.start,
          children: texts,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
              child: Image.asset(widget.path),
              backgroundColor: Colors.white,
              radius: 18,
            ),
            SizedBox(
              width: 15,
            ),
            Expanded(
              child: MyFont(
                text: widget.title,
                size: 20,
                weight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: widget.chat.length,
              itemBuilder: (context, index) {
                var isSender = widget.chat[index]['isSender'];
                return BubbleSpecialThree(
                  text: widget.chat[index]['text'],
                  color: isSender ? Colors.grey.shade300 : Colors.black,
                  textStyle:
                      TextStyle(color: isSender ? Colors.black : Colors.white),
                  tail: false,
                  isSender: isSender,
                );
              },
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 20),
            child: Chattextfield(
              controller: messageController,
              onSend: () async {
                String userMessage = messageController.text;

                setState(() {
                  // db.chatMessages.add(customBubble(l));
                });
              },
              onLocation: () {},
              ai: true,
            ),
          ),
        ],
      ),
    );
  }
}

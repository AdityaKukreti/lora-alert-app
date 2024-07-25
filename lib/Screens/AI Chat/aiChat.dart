import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/Code/chatTextField.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Database/hiveDatabase.dart';
import 'package:lora_chatapp/Helper%20Function/api.dart';

class AIChat extends StatefulWidget {
  const AIChat({super.key});

  @override
  State<AIChat> createState() => _AIChatState();
}

class _AIChatState extends State<AIChat> {
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
            SizedBox(
              width: 10,
            ),
            CircleAvatar(
              child: Image.asset("lib/Assets/Images/5821280.png"),
              backgroundColor: Colors.white,
              radius: 18,
            ),
            SizedBox(
              width: 15,
            ),
            MyFont(
              text: "P L U T O",
              size: 25,
              weight: FontWeight.w600,
              color: Colors.black,
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.only(top: 10),
              itemCount: db.chatMessages.length,
              itemBuilder: (context, index) {
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    child: db.chatMessages[index]);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Chattextfield(
              controller: messageController,
              onSend: () async {
                String userMessage = messageController.text;
                db.chatMessages.add(BubbleSpecialThree(
                  text: userMessage,
                  isSender: true,
                  tail: false,
                  color: Colors.grey.shade300,
                  textStyle: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w400),
                ));
                setState(() {});
                messageController.clear();

                String response = await getResponse(userMessage, <String>[]);
                messageController.clear();
                List<Widget> l = [];
                print(response);
                var splitData = response.split('\n');

                for (var line in splitData) {
                  if (line == "") {
                    l.add(Text(""));
                  } else if (line.startsWith('<h>')) {
                    line = line.replaceAll('<h>', "");
                    line = line.replaceAll('</h>', "");
                    l.add(Text(
                      line,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 15),
                    ));
                  } else if (line.startsWith('<sb>')) {
                    line = line.replaceAll('<sb>', "");
                    line = line.replaceAll('</sb>', "");
                    l.add(Text(
                      line,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                          fontSize: 14.5),
                    ));
                  } else if (line.startsWith('<i>')) {
                    line = line.replaceAll('<i>', "");
                    line = line.replaceAll('</i>', "");
                    l.add(Text(
                      line,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 14),
                    ));
                  }
                }
                setState(() {
                  db.chatMessages.add(customBubble(l));
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

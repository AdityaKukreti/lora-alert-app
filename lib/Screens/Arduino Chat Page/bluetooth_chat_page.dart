import 'dart:async';

import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Helper%20Function/getLocation.dart';

import '../../Assets/Code/chatTextField.dart';

class BluetoothChatPage extends StatefulWidget {
  final BluetoothDevice device;

  const BluetoothChatPage({required this.device, super.key});

  @override
  _BluetoothChatPageState createState() => _BluetoothChatPageState();
}

class _BluetoothChatPageState extends State<BluetoothChatPage> {
  late BluetoothConnection connection;
  List<Widget> messages = [];
  final TextEditingController _textController = TextEditingController();
  bool isConnecting = true;

  @override
  void initState() {
    super.initState();
    _connect(widget.device.address);
  }

  Future<void> _sendData(String data) async {
    data = data.trim();
    try {
      List<int> list = data.codeUnits;
      Uint8List bytes = Uint8List.fromList(list);
      connection.output.add(bytes);
      await connection.output.allSent;
      setState(() {
        messages.add(
          BubbleSpecialThree(
            text: data,
            isSender: true,
            tail: false,
            color: Colors.grey.shade300,
            textStyle:
                TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
          ),
        );
      });
      if (kDebugMode) {
        print('Data sent successfully');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> _connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      setState(() {
        isConnecting = false;
      });
      _sendData('Connected');
      connection.input!.listen((Uint8List data) {
        String receivedData = String.fromCharCodes(data);
        setState(() {
          messages.add(
            BubbleSpecialThree(
              text: receivedData,
              isSender: false,
              tail: false,
              color: Colors.blue.shade200,
              textStyle:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.w400),
            ),
          );
        });
      });
    } catch (exception) {
      print("Cannot connect, exception occurred: $exception");
      setState(() {
        isConnecting = false;
      });
    }
  }

  @override
  void dispose() {
    connection.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyFont(
          text: "Chat with ${widget.device.name}",
          size: 22,
          weight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            isConnecting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : Expanded(
                    child: ListView.builder(
                      padding: EdgeInsets.only(top: 10),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        return Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            child: messages[index]);
                      },
                    ),
                  ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 0, right: 0),
              child: Chattextfield(
                controller: _textController,
                onSend: () {
                  if (_textController.text.isNotEmpty) {
                    _sendData(_textController.text);
                    _textController.clear();
                  }
                },
                onLocation: () {
                  print("Longitude: $longitude\nLatitude: $latitude");
                  _sendData("Longitude: $longitude\nLatitude: $latitude");
                },
                ai: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

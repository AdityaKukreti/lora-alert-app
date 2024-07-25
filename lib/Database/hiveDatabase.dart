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

  List<Map<String, dynamic>> chatMessagesSDMA = [
    {
      "text":
          "Hi, can you provide updates on the cyclone situation in our state?",
      "isSender": true
    },
    {
      "text":
          "Hello! The cyclone has made landfall in the coastal areas, causing significant damage. Emergency services are active, and evacuation orders have been issued for low-lying areas. Please stay indoors and follow official advisories.",
      "isSender": false
    },
    {
      "text": "Which areas are the most affected by the cyclone?",
      "isSender": true
    },
    {
      "text":
          "The coastal regions of Alang, Veraval, and Porbandar are the worst hit. High winds and heavy rains have caused flooding and power outages. Rescue operations are underway in these areas.",
      "isSender": false
    },
    {"text": "Are there any emergency shelters available?", "isSender": true},
    {
      "text":
          "Yes, several shelters have been set up in safe zones. You can go to City Hall, the Primary School in Sector 5, and the Community Center. They have all the necessary amenities and are staffed by volunteers.",
      "isSender": false
    },
    {"text": "What should I do if someone is missing?", "isSender": true},
    {
      "text":
          "Please report missing persons immediately to our helpline at 1800-123-456. Provide as many details as possible. Our search and rescue teams are working around the clock to locate and assist everyone.",
      "isSender": false
    },
    {
      "text": "How can I stay informed about the latest updates?",
      "isSender": true
    },
    {
      "text":
          "You can stay informed by following our official social media channels and website. Additionally, sign up for SMS alerts by texting 'CYCLONE' to 56789 for real-time updates.",
      "isSender": false
    },
    {"text": "Thank you for the information. Stay safe!", "isSender": true},
    {
      "text":
          "You're welcome! Please stay safe and heed all safety instructions. If you have further questions or need assistance, don't hesitate to contact us.",
      "isSender": false
    }
  ];

  List<Map<String, dynamic>> chatMessagesNDMA = [
    {
      "text":
          "Hello, I need information about the earthquake that happened recently.",
      "isSender": true
    },
    {
      "text":
          "Hello! The recent earthquake has caused damage in several regions. We are coordinating with state authorities to assess the impact and deploy necessary resources. Please stay calm and follow safety protocols.",
      "isSender": false
    },
    {"text": "Which regions are the most affected?", "isSender": true},
    {
      "text":
          "The most affected regions are Himachal Pradesh, Uttarakhand, and parts of Delhi. There have been reports of structural damage and casualties. Rescue operations are in progress.",
      "isSender": false
    },
    {"text": "What should I do if my house is damaged?", "isSender": true},
    {
      "text":
          "If your house is damaged, ensure that everyone is safe and evacuate immediately if necessary. Contact local authorities and report the damage. Temporary shelters are available at designated locations.",
      "isSender": false
    },
    {"text": "How can I help with the relief efforts?", "isSender": true},
    {
      "text":
          "You can help by donating to verified relief funds and volunteering with local NGOs. Ensure you follow official guidelines and avoid spreading rumors. Every contribution makes a difference.",
      "isSender": false
    },
    {
      "text": "Is there any hotline for emergency assistance?",
      "isSender": true
    },
    {
      "text":
          "Yes, for emergency assistance, please call our hotline at 112. Our teams are on standby to provide help and support. Stay connected for further updates.",
      "isSender": false
    },
    {"text": "Thank you for your support!", "isSender": true},
    {
      "text":
          "You're welcome! We're here to help. Stay safe and reach out if you need any further assistance.",
      "isSender": false
    }
  ];

  List<Map<String, dynamic>> chatMessagesNDRF = [
    {
      "text":
          "Hi, can you tell me about the current flood situation in the city?",
      "isSender": true
    },
    {
      "text":
          "Hello! The city is experiencing severe flooding due to heavy rains. NDRF teams are deployed for rescue and relief operations. Please avoid flooded areas and move to higher ground if necessary.",
      "isSender": false
    },
    {
      "text": "Which areas are the most affected by the floods?",
      "isSender": true
    },
    {
      "text":
          "The most affected areas include the Riverside, Old Town, and the Industrial Zone. These areas are under deep water, and many roads are impassable. Evacuation is in progress.",
      "isSender": false
    },
    {
      "text": "What should I do if I need immediate assistance?",
      "isSender": true
    },
    {
      "text":
          "For immediate assistance, please call our emergency helpline at 101. Our rescue teams are actively responding to calls and will reach you as soon as possible.",
      "isSender": false
    },
    {"text": "Are there any safety tips I should follow?", "isSender": true},
    {
      "text":
          "Yes, avoid walking or driving through floodwaters, as they can be deeper and faster-moving than they appear. Stay informed through official channels and prepare an emergency kit with essential supplies.",
      "isSender": false
    },
    {"text": "How can I stay updated on the situation?", "isSender": true},
    {
      "text":
          "Stay updated by following our official Twitter handle and website. You can also sign up for SMS alerts by sending 'FLOODINFO' to 12345. We provide real-time updates and safety information.",
      "isSender": false
    },
    {
      "text": "Thank you for the information and your efforts!",
      "isSender": true
    },
    {
      "text":
          "You're welcome! Stay safe, and don't hesitate to contact us for any help. We're here to assist you.",
      "isSender": false
    }
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

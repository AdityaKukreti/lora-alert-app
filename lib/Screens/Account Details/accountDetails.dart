import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Assets/Code/textfield.dart';
import 'package:lora_chatapp/Database/database.dart';

class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  TextEditingController emailController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  @override
  void initState() {
    emailController.text = userdb.userData['email'];
    genderController.text = userdb.userData['gender'];
    stateController.text = userdb.userData['state'];
    dobController.text =
        userdb.userData['dob'].toDate().toString().substring(0, 10);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyFont(
          text: "A C C O U N T   D E T A I L S",
          color: Colors.black,
          weight: FontWeight.w600,
          size: 20,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Center(
          child: Column(
            children: [
              CircleAvatar(
                child: Image.asset(
                  "lib/Assets/Images/profile-picture.png",
                ),
                radius: 50,
              ),
              MyFont(
                  text: "@${userdb.userData['userid']}",
                  size: 16,
                  weight: FontWeight.w600,
                  color: Colors.black45),
              MyFont(
                  text: "${userdb.userData['name']}",
                  size: 18,
                  weight: FontWeight.w600,
                  color: Colors.black87),
              SizedBox(
                height: 40,
              ),
              DisabledTextfield(
                  controller: emailController,
                  text: 'Email',
                  icon: Icons.email),
              SizedBox(
                height: 20,
              ),
              DisabledTextfield(
                  controller: genderController,
                  text: 'Gender',
                  icon: Icons.people),
              SizedBox(
                height: 20,
              ),
              DisabledTextfield(
                  controller: stateController,
                  text: 'State',
                  icon: Icons.location_on),
              SizedBox(
                height: 20,
              ),
              DisabledTextfield(
                  controller: dobController,
                  text: 'DOB',
                  icon: Icons.calendar_month),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Screens/Account%20Details/accountDetails.dart';

import '../Signin/signin.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DrawerHeader(
                margin: EdgeInsets.zero,
                child: Container(
                  margin: const EdgeInsets.only(top: 40),
                  child: const Text(
                    "Lora Alert App",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 25,
                        letterSpacing: 2),
                  ),
                )),
            ListTile(
              title: Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(
                    width: 10,
                  ),
                  MyFont(
                    text: "Account Details",
                    size: 20,
                    weight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return AccountDetails();
                }));
              },
            ),
            ListTile(
              title: const Row(
                children: [
                  Icon(Icons.exit_to_app_rounded),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Logout",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 3),
                  ),
                ],
              ),
              onTap: () async {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return SignInScreen();
                }));
              },
            )
          ],
        ),
      ),
    );
  }
}

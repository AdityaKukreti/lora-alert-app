import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/font.dart';
import 'package:lora_chatapp/Assets/textfield.dart';
import 'package:lora_chatapp/Screens/HomeScreen/homescreen.dart';
import 'package:lora_chatapp/Screens/SignUp/signup.dart';

import '../../Assets/button.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MyFont(
                  text: "S I G N   I N",
                  size: 30,
                  weight: FontWeight.w600,
                  color: Colors.black),
              SizedBox(
                height: 20,
              ),
              MyTextField(
                controller: emailController,
                text: "Enter your email",
                icon: Icons.mail,
              ),
              SizedBox(
                height: 20,
              ),
              PasswordTextfield(
                controller: passwordController,
                text: "Enter your password",
              ),
              SizedBox(
                height: 50,
              ),
              Button(
                text: "Sign In",
                textColor: Colors.white,
                backgroundColor: Colors.black,
                function: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return HomePage();
                  }));
                },
                textSize: 20,
                width: 200,
                height: 50,
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyFont(
                      text: "Don't have an account? ",
                      size: 17,
                      weight: FontWeight.w400,
                      color: Colors.black),
                  InkWell(
                    child: MyFont(
                        text: "Sign up",
                        size: 17,
                        weight: FontWeight.w500,
                        color: Colors.blueGrey),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SignUpScreen();
                      }));
                    },
                    splashColor: Colors.transparent,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

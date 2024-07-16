import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/font.dart';
import 'package:lora_chatapp/Assets/textfield.dart';
import 'package:lora_chatapp/Screens/SignUp/details.dart';

import '../../Assets/button.dart';
import '../Signin/signin.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController rePasswordController = new TextEditingController();
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
                  text: "S I G N   U P",
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
                height: 20,
              ),
              PasswordTextfield(
                controller: rePasswordController,
                text: "Re-enter your password",
              ),
              SizedBox(
                height: 50,
              ),
              Button(
                text: "Sign Up",
                textColor: Colors.white,
                backgroundColor: Colors.black,
                function: () async {
                  String email = emailController.text;
                  String pass1 = passwordController.text;
                  String pass2 = rePasswordController.text;
                  if (email.isEmpty || pass1.isEmpty || pass2.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("One of the fields is empty")));
                  } else if (pass1 != pass2) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text("Entered passwords do not match")));
                  } else {
                    try {
                      UserCredential? userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                              email: email, password: pass1);
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Details();
                      }));
                    } on FirebaseAuthException catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text(
                              "An error occured. Please try again after sometime...")));
                    }
                  }
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
                      text: "Already have an account? ",
                      size: 17,
                      weight: FontWeight.w400,
                      color: Colors.black),
                  InkWell(
                    child: MyFont(
                        text: "Sign in",
                        size: 17,
                        weight: FontWeight.w500,
                        color: Colors.blueGrey),
                    onTap: () {
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (context) {
                        return SignInScreen();
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

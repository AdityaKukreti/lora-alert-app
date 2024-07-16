import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/button.dart';
import 'package:lora_chatapp/Assets/dropdown.dart';
import 'package:lora_chatapp/Assets/font.dart';
import 'package:lora_chatapp/Assets/textfield.dart';
import 'package:lora_chatapp/Database/database.dart';
import 'package:lora_chatapp/Screens/HomeScreen/homescreen.dart';

class Details extends StatefulWidget {
  const Details({super.key});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  TextEditingController nameController = new TextEditingController();
  TextEditingController usernameController = new TextEditingController();
  TextEditingController genderController = new TextEditingController();
  TextEditingController stateController = new TextEditingController();
  DateTime? pickedDate;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.all(30),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MyFont(
                    text: "U S E R   D E T A I L S",
                    size: 30,
                    weight: FontWeight.w600,
                    color: Colors.black),
                SizedBox(
                  height: 50,
                ),
                MyTextField(
                    controller: nameController,
                    text: "Enter your fullname",
                    icon: Icons.person),
                SizedBox(
                  height: 20,
                ),
                MyTextField(
                    controller: usernameController,
                    text: "Enter your username",
                    icon: CupertinoIcons.at),
                SizedBox(
                  height: 20,
                ),
                DropDownMenu(
                  text: 'Select your gender',
                  icon: Icons.people,
                  list: [
                    DropdownMenuEntry(value: "Male", label: "Male"),
                    DropdownMenuEntry(value: "Female", label: "Female"),
                    DropdownMenuEntry(value: "Other", label: "Others"),
                  ],
                  controller: genderController,
                ),
                SizedBox(
                  height: 20,
                ),
                DropDownMenu(
                  text: 'Select your state',
                  icon: Icons.location_on,
                  list: [
                    DropdownMenuEntry(
                        value: "Andaman and Nicobar Islands",
                        label: "Andaman and Nicobar Islands"),
                    DropdownMenuEntry(
                        value: "Andhra Pradesh", label: "Andhra Pradesh"),
                    DropdownMenuEntry(
                        value: "Arunachal Pradesh", label: "Arunachal Pradesh"),
                    DropdownMenuEntry(value: "Assam", label: "Assam"),
                    DropdownMenuEntry(value: "Bihar", label: "Bihar"),
                    DropdownMenuEntry(value: "Chandigarh", label: "Chandigarh"),
                    DropdownMenuEntry(
                        value: "Chhattisgarh", label: "Chhattisgarh"),
                    DropdownMenuEntry(
                        value: "Dadra and Nagar Haveli and Daman and Diu",
                        label: "Dadra and Nagar Haveli and Daman and Diu"),
                    DropdownMenuEntry(value: "Delhi", label: "Delhi"),
                    DropdownMenuEntry(value: "Goa", label: "Goa"),
                    DropdownMenuEntry(value: "Gujarat", label: "Gujarat"),
                    DropdownMenuEntry(value: "Haryana", label: "Haryana"),
                    DropdownMenuEntry(
                        value: "Himachal Pradesh", label: "Himachal Pradesh"),
                    DropdownMenuEntry(
                        value: "Jammu and Kashmir", label: "Jammu and Kashmir"),
                    DropdownMenuEntry(value: "Jharkhand", label: "Jharkhand"),
                    DropdownMenuEntry(value: "Karnataka", label: "Karnataka"),
                    DropdownMenuEntry(value: "Kerala", label: "Kerala"),
                    DropdownMenuEntry(value: "Ladakh", label: "Ladakh"),
                    DropdownMenuEntry(
                        value: "Lakshadweep", label: "Lakshadweep"),
                    DropdownMenuEntry(
                        value: "Madhya Pradesh", label: "Madhya Pradesh"),
                    DropdownMenuEntry(
                        value: "Maharashtra", label: "Maharashtra"),
                    DropdownMenuEntry(value: "Manipur", label: "Manipur"),
                    DropdownMenuEntry(value: "Meghalaya", label: "Meghalaya"),
                    DropdownMenuEntry(value: "Mizoram", label: "Mizoram"),
                    DropdownMenuEntry(value: "Nagaland", label: "Nagaland"),
                    DropdownMenuEntry(value: "Odisha", label: "Odisha"),
                    DropdownMenuEntry(value: "Puducherry", label: "Puducherry"),
                    DropdownMenuEntry(value: "Punjab", label: "Punjab"),
                    DropdownMenuEntry(value: "Rajasthan", label: "Rajasthan"),
                    DropdownMenuEntry(value: "Sikkim", label: "Sikkim"),
                    DropdownMenuEntry(value: "Tamil Nadu", label: "Tamil Nadu"),
                    DropdownMenuEntry(value: "Telangana", label: "Telangana"),
                    DropdownMenuEntry(value: "Tripura", label: "Tripura"),
                    DropdownMenuEntry(
                        value: "Uttar Pradesh", label: "Uttar Pradesh"),
                    DropdownMenuEntry(
                        value: "Uttarakhand", label: "Uttarakhand"),
                    DropdownMenuEntry(
                        value: "West Bengal", label: "West Bengal"),
                  ],
                  controller: stateController,
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(14),
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(20)),
                  child: InkWell(
                    onTap: () async {
                      pickedDate = await showDatePicker(
                          context: context,
                          firstDate: DateTime(1920),
                          lastDate: DateTime.now());
                      setState(() {});
                    },
                    child: Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(
                          width: 15,
                        ),
                        MyFont(
                            text: pickedDate != null
                                ? pickedDate.toString().substring(0, 10)
                                : "yyyy-mmm-dd",
                            size: 15,
                            weight: FontWeight.w400,
                            color: Colors.black)
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
                Button(
                    function: () {
                      var name = nameController.text;
                      var username = usernameController.text;
                      var gender = genderController.text;
                      var state = stateController.text;
                      var date = pickedDate;

                      if (name.isEmpty ||
                          username.isEmpty ||
                          gender.isEmpty ||
                          state.isEmpty ||
                          date == null) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text("One or more fields are empty")));
                      } else {
                        try {
                          FirestoreDatabase()
                              .addUser(name, username, gender, state, date);
                          Navigator.pop(context);
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return HomePage();
                          }));
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  "An error occured, try again after sometime...")));
                        }
                      }
                    },
                    text: "Register",
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textSize: 20,
                    width: 180,
                    height: 50),
                SizedBox(
                  height: 50,
                )
              ],
            ),
          ),
        ));
  }
}

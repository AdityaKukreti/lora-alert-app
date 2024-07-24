import 'package:flutter/material.dart';
import 'package:lora_chatapp/Assets/Code/button.dart';
import 'package:lora_chatapp/Assets/Code/font.dart';
import 'package:lora_chatapp/Database/database.dart';

import '../../Assets/Code/dropdown.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController titleController = TextEditingController();
  TextEditingController postController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController disasterController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: MyFont(
          text: "A D D   P O S T",
          weight: FontWeight.w600,
          size: 22,
          color: Colors.black,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Column(
          children: [
            TextField(
              minLines: 1,
              maxLines: 2,
              controller: titleController,
              decoration: InputDecoration(
                  hintText: "Write your post title here...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              minLines: 3,
              maxLines: 6,
              maxLength: 250,
              controller: postController,
              decoration: InputDecoration(
                  hintText: "Write your post here...",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
            SizedBox(
              height: 10,
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
                DropdownMenuEntry(value: "Chhattisgarh", label: "Chhattisgarh"),
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
                DropdownMenuEntry(value: "Lakshadweep", label: "Lakshadweep"),
                DropdownMenuEntry(
                    value: "Madhya Pradesh", label: "Madhya Pradesh"),
                DropdownMenuEntry(value: "Maharashtra", label: "Maharashtra"),
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
                DropdownMenuEntry(value: "Uttarakhand", label: "Uttarakhand"),
                DropdownMenuEntry(value: "West Bengal", label: "West Bengal"),
              ],
              controller: stateController,
            ),
            SizedBox(
              height: 20,
            ),
            DropDownMenu(
              text: 'Select disaster type',
              icon: Icons.cloud,
              list: [
                DropdownMenuEntry(value: "Avalanche", label: "Avalanche"),
                DropdownMenuEntry(value: "Blizzard", label: "Blizzard"),
                DropdownMenuEntry(value: "Cyclone", label: "Cyclone"),
                DropdownMenuEntry(value: "Drought", label: "Drought"),
                DropdownMenuEntry(value: "Earthquake", label: "Earthquake"),
                DropdownMenuEntry(value: "Flood", label: "Flood"),
                DropdownMenuEntry(value: "Hurricane", label: "Hurricane"),
                DropdownMenuEntry(value: "Landslide", label: "Landslide"),
                DropdownMenuEntry(value: "Pandemic", label: "Pandemic"),
                DropdownMenuEntry(value: "Sandstorm", label: "Sandstorm"),
                DropdownMenuEntry(value: "Tornado", label: "Tornado"),
                DropdownMenuEntry(value: "Tsunami", label: "Tsunami"),
                DropdownMenuEntry(value: "Wildfire", label: "Wildfire"),
              ],
              controller: disasterController,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Button(
                    function: () {
                      Navigator.pop(context);
                    },
                    text: "Cancel",
                    backgroundColor: Colors.purple.shade50,
                    textColor: Colors.black,
                    textSize: 17,
                    width: 120,
                    height: 45),
                SizedBox(
                  width: 10,
                ),
                Button(
                    function: () {
                      try {
                        userdb.addPost(
                            stateController.text,
                            disasterController.text,
                            titleController.text,
                            postController.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Posted Successfully")));
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("Error occured")));
                      }
                      Navigator.pop(context);
                    },
                    text: "Post",
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textSize: 17,
                    width: 120,
                    height: 45),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

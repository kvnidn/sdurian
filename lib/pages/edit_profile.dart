import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset:
          true, // Allow the screen to resize when the keyboard appears
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBF00),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Change arrow color here
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Edit Profile",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          // Wrap your content with SingleChildScrollView
          child: Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: 300),
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  _buildGreeting(),
                  SizedBox(
                    height: 25,
                  ),
                  _buildEditForm("Username", "Enter your username"),
                  _buildEditForm("Full Name", "Enter your full name"),
                  _buildEditForm("Phone Number", "Enter your phone number"),
                  _buildSaveButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Container(
      constraints: BoxConstraints(maxWidth: 280),
      alignment: Alignment.center,
      child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.asset(
          "lib/assets/durian_king.png",
          width: 150,
          height: 150,
        ),
        Text(
          "Edit Profile",
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Text("Make sure to save your changes before leaving",
            style: TextStyle(fontSize: 18), textAlign: TextAlign.center)
      ]),
    );
  }

  Widget _buildEditForm(String label, String hint,
      {TextEditingController? controller}) {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            style: TextStyle(fontSize: 16),
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              labelText: label,
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFFFBF00),
                    width: 2.0), // Color of the enabled border
                borderRadius: BorderRadius.circular(30),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xFFFFBF00),
                    width: 2.0), // Color of the focused border
                borderRadius: BorderRadius.circular(30),
              ),
              labelStyle: TextStyle(color: Colors.black.withOpacity(0.5)),
              floatingLabelStyle: TextStyle(color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildSaveButton() {
    return Container(
      alignment: Alignment.center,
      width: 100,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color(0xFFFFBF00),
      ),
      child: GestureDetector(
        onTap: () {}, // Pending
        child: Text(
          "Save",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

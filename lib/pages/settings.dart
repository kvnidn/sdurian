import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdurian/authentication.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/about.dart';
import 'package:sdurian/pages/edit_profile.dart';
import 'package:sdurian/pages/login/login.dart';

class Settings extends StatefulWidget {
  final User user;
  const Settings({Key? key, required this.user}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFFBF00),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Settings",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: Center(
        child: SafeArea(
            child: Container(
          child: Column(children: [
            _buildSettingsMenu(
              "Edit Profile",
              FontAwesomeIcons.user,
              EditProfile(
                user: widget.user,
              ),
            ),
            _buildSettingsMenu("About Us", FontAwesomeIcons.question, About()),
            _buildSettingsMenuLogOut(
              "Log Out",
              FontAwesomeIcons.rightFromBracket,
              LogInScreen(),
            ),
          ]),
        )),
      )),
    );
  }

  Widget _buildSettingsMenu(String name, IconData icon, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        margin: EdgeInsets.only(top: 14, left: 10, right: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ],
          color: Color(0xFFFFBF00),
        ),
        width: 300,
        height: 80,
        child: Row(
          children: [
            // Icon container
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: Colors.white,
              ),
              child: Icon(
                icon,
                size: 25,
              ),
            ),
            SizedBox(width: 10), // Add some space between icon and text
            // Text
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.center, // Center the text horizontally
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsMenuLogOut(
      String name, IconData icon, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
        Auth().logout();
      },
      child: Container(
        margin: EdgeInsets.only(top: 14, left: 10, right: 10),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            )
          ],
          color: Color(0xFFFFBF00),
        ),
        width: 300,
        height: 80,
        child: Row(
          children: [
            // Icon container
            Container(
              margin: EdgeInsets.only(left: 20),
              width: 60,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: Colors.white,
              ),
              child: Icon(
                icon,
                size: 25,
              ),
            ),
            SizedBox(width: 10), // Add some space between icon and text
            // Text
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.center, // Center the text horizontally
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdurian/authentication.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/about.dart';
import 'package:sdurian/pages/edit_profile.dart';
import 'package:sdurian/pages/login/login.dart';
import 'package:sdurian/pages/paymentScreen.dart';
import 'package:sdurian/pages/settings.dart';
import 'package:sdurian/pages/splash/splash_screen.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          "Profile",
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
            const SizedBox(height: 30),
            Stack(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: AssetImage('lib/assets/profile.jpg'))),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.user.username,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, size: 20, color: Colors.black),
                SizedBox(width: 10),
                Text(widget.user.phoneNumber, style: TextStyle(fontSize: 16)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, size: 20, color: Colors.blue),
                SizedBox(width: 10),
                Text(widget.user.email,
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                        decoration: TextDecoration.underline)),
              ],
            ),
            SizedBox(height: 20),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditProfile(user: widget.user)),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFFBF00),
                    side: BorderSide.none,
                    shape: const StadiumBorder()),
                child: const Text('Edit Profile',
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Colors.grey, // Color yang lebih samar
              thickness: 0.5, // Ketebalan divider
              indent: 50, // Jarak dari kiri
              endIndent: 50, // Jarak dari kanan
            ),
            _buildSettingsMenu(
              "Payment",
              Icons.credit_card,
              PaymentsScreen(),
            ),
            _buildSettingsMenu("About Us", FontAwesomeIcons.question, About()),
            _buildSettingsMenu("Settings", FontAwesomeIcons.gear, Settings()),
          ]),
        )),
      )),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: _buildSettingsMenuLogOut(
          "Log Out",
          FontAwesomeIcons.signOutAlt,
          SplashScreen(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
        width: 300,
        height: 70,
        child: Row(
          children: [
            // Icon container
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: Color.fromARGB(255, 225, 223, 255),
              ),
              child: Icon(
                icon,
                size: 20,
                color: const Color(0xFF0912C7),
              ),
            ),
            SizedBox(width: 10), // Add some space between icon and text
            // Text
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.left, // Center the text horizontally
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(
                Icons.arrow_forward,
                size: 20,
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsMenuLogOut(
      String name, IconData icon, Widget destination) {
    return SizedBox(
      width: 200,
      height: 50,
      child: ElevatedButton.icon(
        onPressed: () {
          Auth().logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          side: BorderSide.none,
          shape: const StadiumBorder(),
        ),
        icon: Icon(icon, color: Colors.white),
        label: Text(
          name,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

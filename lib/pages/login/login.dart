import 'package:flutter/material.dart';
import 'package:sdurian/pages/login/components/body.dart';
import 'package:sdurian/navbar.dart';

class LogInScreen extends StatelessWidget {
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Navigator.pushNamed(context, NavBar.routeName);
          },
        ),
      ),
      body: Body(),
    );
  }
}
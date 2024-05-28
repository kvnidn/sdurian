import 'package:flutter/material.dart';

import 'components/body.dart';

class ForgotPwScreen extends StatelessWidget {
  static String routeName = "/forgotpw";

  // const ForgotPwScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Forgot Password"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}
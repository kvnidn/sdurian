import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdurian/pages/login/components/body.dart';
import 'package:sdurian/pages/splash/splash_screen.dart';

class LogInScreen extends StatelessWidget {
  static String routeName = "/login";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log In"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.pushNamed(context, SplashScreen.routeName);
          },
        ),
      ),
      body: Body(),
    );
  }
}

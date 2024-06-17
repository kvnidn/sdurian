import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdurian/pages/signup/signup.dart';

import 'components/body.dart';

class CompleteProfileScreen extends StatelessWidget {
  static String routeName = '/cprofile';

  final String email;
  final String hashedPassword;
  final String salt;

  CompleteProfileScreen({
    required this.email,
    required this.hashedPassword,
    required this.salt,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignUpScreen()));
          },
        ),
      ),
      body: Body(
        email: email,
        hashedPassword: hashedPassword,
        salt: salt,
      ),
    );
  }
}

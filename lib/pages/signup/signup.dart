import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdurian/pages/login/login.dart';

import 'components/body.dart';

class SignUpScreen extends StatelessWidget {
  static String routeName = "/signup";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Iconsax.arrow_left_2),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => LogInScreen()));
          },
        ),
        title: Text("Sign Up"),
        centerTitle: true,
      ),
      body: Body(),
    );
  }
}

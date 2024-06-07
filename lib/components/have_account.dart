import 'package:flutter/material.dart';

import '../utils/constants/constants.dart';
import '../pages/login/login.dart';
import '../size_config.dart';

class haveAccount extends StatelessWidget {
  const haveAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Already have an account? ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(12),
            color: Colors.black,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, LogInScreen.routeName),
          child: Text(
            "Log in",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
              fontWeight: FontWeight.bold,
              color: Colors.black,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}

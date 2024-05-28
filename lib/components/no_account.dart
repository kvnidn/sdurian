import 'package:flutter/material.dart';
import 'package:sdurian/constants.dart';
import 'package:sdurian/pages/signup/signup.dart';
import '../size_config.dart';

class noAccount extends StatelessWidget {
  const noAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(
            fontSize: getProportionateScreenWidth(12),
            color: kTextLightColor,
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, SignUpScreen.routeName),
          child: Text(
            "Sign Up",
            style: TextStyle(
              fontSize: getProportionateScreenWidth(12),
              fontWeight: FontWeight.bold,
              color: kTextLightColor,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
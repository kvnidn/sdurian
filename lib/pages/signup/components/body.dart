import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/constants.dart';
import 'package:sdurian/size_config.dart';

import 'signup_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getProportionateScreenWidth(20),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(30),
                ),
                Container(
                  height: getProportionateScreenHeight(72.15),
                  width: getProportionateScreenWidth(66),
                  child: Image.asset(
                    "lib/assets/durianking.png",
                  ),
                ),
                SizedBox(
                  height: getProportionateScreenHeight(20),
                ),
                Text(
                  "Register Account",
                  style: headingStyle,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Sign up with your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextLightColor,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(25)),
                SignUpForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

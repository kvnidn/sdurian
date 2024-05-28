import 'package:flutter/material.dart';
import 'package:sdurian/size_config.dart';

const kPrimaryColor = Color(0xFFFFBF00);
const kPrimaryLightColor = Color(0xFFFFECB3);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFFFBF00), Color(0xFFFFECB3)], 
);
const kSecondaryColor = Color(0xFFFFFFFF);
const kTextColor = Color(0xFF000000);
const kTextLightColor = Color(0xFF000000);

const kAnimationDuration = Duration(milliseconds: 200);

final headingStyle = TextStyle(
                      fontSize: getProportionateScreenWidth(28),
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    );

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please enter your email";
const String kInvalidEmailError = "Please enter valid email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password is too short";
const String kMatchPassError = "Passwords don't match";
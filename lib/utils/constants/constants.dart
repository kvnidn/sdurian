import 'package:flutter/material.dart';
import 'package:sdurian/size_config.dart';

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
);

// Form Error
final RegExp emailValidatorRegExp =
    RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
const String kEmailNullError = "Please enter your email";
const String kEmailExistError = "Email is already registered";
const String kInvalidEmailError = "Please enter valid email";
const String kPassNullError = "Please enter your password";
const String kShortPassError = "Password min. 8 characters";
const String kMatchPassError = "Passwords don't match";
const String kProfileNotCompleted = "Profile must be completed";

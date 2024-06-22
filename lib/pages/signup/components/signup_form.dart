import 'package:flutter/material.dart';
import 'package:sdurian/components/default_button.dart';
import 'package:sdurian/components/have_account.dart';
import 'package:sdurian/utils/constants/constants.dart';
import 'package:sdurian/pages/complete_profile/cpscreen.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/size_config.dart';
import 'package:random_string/random_string.dart';
import 'package:sdurian/components/form_error.dart';
import 'package:collection/collection.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();

  String? email;
  String? password;
  String? confirm_password;
  final List<String> errors = [];

  void addError({required String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({required String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  bool isEmailExist = false;

  void validateUserCredentials(String email, String password) async {
    // Clear previous errors
    setState(() {
      errors.clear();
    });

    try {
      // Fetch user data
      await User.fetchUserData();

      // Check if user exists with entered email
      User? user =
          User.userList.firstWhereOrNull((user) => user.email == email);
      if (user != null) {
        // User found, email is registered
        // Proceed with your logic, e.g., show error or navigate to login screen
        setState(() {
          errors.add(kEmailExistError);
        });
      } else {
        if (ValidatePasswordNull()) {
          if (ValidatePasswordShort()) {
            if (validatePasswordMatch()) {
              String salt = randomAlphaNumeric(16);

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CompleteProfileScreen(
                    email: email!,
                    hashedPassword: User.hashPassword(password!, salt),
                    salt: salt,
                  ),
                ),
              );
            }
          }
        }
        // User not found, email is not registered
        // Proceed with your logic, e.g., allow user to register or show error
      }
    } catch (error) {
      print("Error fetching user data: $error");
      setState(() {
        errors.add("Error fetching user data: $error");
      });
    }
  }

  bool ValidateEmailNull() {
    if (email == null || email!.isEmpty) {
      addError(error: kEmailNullError);
      return false;
    }
    return true;
  }

  bool ValidateEmailValid() {
    if ((email != null || email!.isNotEmpty) &&
        !emailValidatorRegExp.hasMatch(email!)) {
      addError(error: kInvalidEmailError);
      return false;
    }
    return true;
  }

  bool ValidatePasswordNull() {
    if (password == null || password!.isEmpty) {
      addError(error: kPassNullError);
      return false;
    }
    return true;
  }

  bool ValidatePasswordShort() {
    if (password!.length < 8) {
      addError(error: kShortPassError);
      return false;
    }
    return true;
  }

  bool validatePasswordMatch() {
    if (password != confirm_password) {
      addError(error: kMatchPassError);
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildEmailFormField(),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildPasswordFormField(),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildConfirmPwFormField(),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FormError(errors: errors),
            ],
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () async {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                errors.clear();
                if (ValidateEmailNull()) {
                  if (ValidateEmailValid()) {
                    validateUserCredentials(email!, password!);
                  }
                }
              }
            },
          ),
          SizedBox(height: getProportionateScreenHeight(30)),
          haveAccount(),
          SizedBox(height: getProportionateScreenHeight(30)),
        ],
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
        keyboardType: TextInputType.emailAddress,
        onSaved: (newValue) => email = newValue!,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: "Email",
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintText: "Enter your email",
          hintStyle: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w300, fontSize: 14),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => password = newValue!,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintText: "Enter your password",
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }

  TextFormField buildConfirmPwFormField() {
    return TextFormField(
        obscureText: true,
        onSaved: (newValue) => confirm_password = newValue!,
        style: TextStyle(
          color: Colors.black,
        ),
        decoration: InputDecoration(
          labelText: "Confirm Password",
          labelStyle: TextStyle(
            color: Colors.black,
          ),
          hintText: "Re-enter your password",
          hintStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w300,
            fontSize: 14,
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ));
  }
}

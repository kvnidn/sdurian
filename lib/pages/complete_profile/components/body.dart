import 'package:flutter/material.dart';
import 'package:sdurian/components/default_button.dart';
import 'package:sdurian/constants.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/signupsuccess/signupscs.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/components/form_error.dart';

class Body extends StatelessWidget {
  final String email;
  final String hashedPassword;
  final String salt;

  const Body({
    Key? key,
    required this.email,
    required this.hashedPassword,
    required this.salt,
  }) : super(key: key);

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
                  "Complete Profile",
                  style: headingStyle,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(10),
                ),
                Text(
                  "Complete your details \nor continue with social media",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextLightColor,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(25)),
                CompleteProfileForm(
                  email: email,
                  hashedPassword: hashedPassword,
                  salt: salt,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompleteProfileForm extends StatefulWidget {
  final String email;
  final String hashedPassword;
  final String salt;

  CompleteProfileForm({
    required this.email,
    required this.hashedPassword,
    required this.salt,
  });

  @override
  State<CompleteProfileForm> createState() => _CompleteProfileFormState();
}

class _CompleteProfileFormState extends State<CompleteProfileForm> {
  final _formKey = GlobalKey<FormState>();

  late String username;
  late String firstName;
  late String lastName;
  late String phoneNumber;
  late String address;
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

  bool ValidateUsernameNull() {
    if (username == null || username!.isEmpty) {
      addError(error: kProfileNotCompleted);
      return false;
    }
    return true;
  }

  bool ValidateFNNull() {
    if (firstName == null || firstName!.isEmpty) {
      addError(error: kProfileNotCompleted);
      return false;
    }
    return true;
  }

  bool ValidateLNNull() {
    if (lastName == null || lastName!.isEmpty) {
      addError(error: kProfileNotCompleted);
      return false;
    }
    return true;
  }

  bool ValidatePNNull() {
    if (phoneNumber == null || phoneNumber!.isEmpty) {
      addError(error: kProfileNotCompleted);
      return false;
    }
    return true;
  }

  bool ValidateAddressNull() {
    if (address == null || address!.isEmpty) {
      addError(error: kProfileNotCompleted);
      return false;
    }
    return true;
  }

  // bool ValidateFormNull() {
  //   if ((username == null || username!.isEmpty) || 
  //       (firstName == null || firstName!.isEmpty) ||
  //       (lastName == null || lastName!.isEmpty) ||
  //       (phoneNumber == null || phoneNumber!.isEmpty) ||
  //       (address == null || address!.isEmpty)) {
  //         addError(error: kProfileNotCompleted);
  //         return false;
  //       }

  //   return true;
  // }

  Future<void> _createUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      try {
        await User.createUser(
          email: widget.email,
          password: widget.hashedPassword,
          salt: widget.salt,
          username: username,
          firstName: firstName,
          lastName: lastName,
          phoneNumber: phoneNumber,
          address: address,
        );
        print("User Added");
        Navigator.pushNamed(context, SignUpScsScreen.routeName);
      } catch (error) {
        print("Failed to add user: $error");
      }
    }
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
            child: buildUsernameFormField(),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildFNFormField(),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildLNFormField(),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildPNFormField(),
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildAddressFormField(),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(62),
            ),
            child: FormError(errors: errors),
          ),
          SizedBox(
            height: getProportionateScreenHeight(20),
          ),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                removeError(error: kProfileNotCompleted);
                if (ValidateUsernameNull()) {
                  if (ValidateFNNull()) {
                    if (ValidateLNNull()) {
                      if (ValidatePNNull()) {
                        if (ValidateAddressNull()) {
                          _createUser();
                        }
                      }
                    }
                  }
                }
              }
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
        ],
      ),
    );
  }

  TextFormField buildUsernameFormField() {
    return TextFormField(
      onSaved: (newValue) => username = newValue!,
      style: TextStyle(
        color: kTextLightColor,
      ),
      decoration: InputDecoration(
        labelText: "Username",
        labelStyle: TextStyle(
          color: kTextLightColor,
        ),
        hintText: "Enter your username",
        hintStyle: TextStyle(
          color: kTextLightColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildFNFormField() {
    return TextFormField(
      onSaved: (newValue) => firstName = newValue!,
      style: TextStyle(
        color: kTextLightColor,
      ),
      decoration: InputDecoration(
        labelText: "First Name",
        labelStyle: TextStyle(
          color: kTextLightColor,
        ),
        hintText: "Enter your first name",
        hintStyle: TextStyle(
          color: kTextLightColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildLNFormField() {
    return TextFormField(
      onSaved: (newValue) => lastName = newValue!,
      style: TextStyle(
        color: kTextLightColor,
      ),
      decoration: InputDecoration(
        labelText: "Last Name",
        labelStyle: TextStyle(
          color: kTextLightColor,
        ),
        hintText: "Enter your last name",
        hintStyle: TextStyle(
          color: kTextLightColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildPNFormField() {
    return TextFormField(
      keyboardType: TextInputType.phone,
      onSaved: (newValue) => phoneNumber = newValue!,
      style: TextStyle(
        color: kTextLightColor,
      ),
      decoration: InputDecoration(
        labelText: "Phone Number",
        labelStyle: TextStyle(
          color: kTextLightColor,
        ),
        hintText: "Enter your phone number",
        hintStyle: TextStyle(
          color: kTextLightColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }

  TextFormField buildAddressFormField() {
    return TextFormField(
      keyboardType: TextInputType.streetAddress,
      onSaved: (newValue) => address = newValue!,
      style: TextStyle(
        color: kTextLightColor,
      ),
      decoration: InputDecoration(
        labelText: "Address",
        labelStyle: TextStyle(
          color: kTextLightColor,
        ),
        hintText: "Enter your address",
        hintStyle: TextStyle(
          color: kTextLightColor,
          fontWeight: FontWeight.w300,
          fontSize: 14,
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}

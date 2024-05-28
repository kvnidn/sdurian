import 'package:flutter/material.dart';
import 'package:sdurian/components/default_button.dart';
import 'package:sdurian/constants.dart';
import 'package:sdurian/pages/signupsuccess/signupscs.dart';
import 'package:sdurian/size_config.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: 
          EdgeInsets.symmetric(
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
                CompleteProfileForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CompleteProfileForm extends StatefulWidget {
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
            height: getProportionateScreenHeight(40),
          ),
          // SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, SignUpScsScreen.routeName);
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
          fontSize: 14
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      )
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
          fontSize: 14
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      )
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
          fontSize: 14
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      )
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
          fontSize: 14
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      )
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
          fontSize: 14
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      )
    );
  }
}
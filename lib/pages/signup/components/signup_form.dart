import 'package:flutter/material.dart';
import 'package:sdurian/components/default_button.dart';
import 'package:sdurian/components/have_account.dart';
import 'package:sdurian/components/social_card.dart';
import 'package:sdurian/constants.dart';
import 'package:sdurian/pages/complete_profile/cpscreen.dart';
import 'package:sdurian/size_config.dart';

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
            height: getProportionateScreenHeight(40),
          ),
          // SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState!.validate()) {
                Navigator.pushNamed(context, CompleteProfileScreen.routeName);
              }
            },
          ),
          SizedBox(
            height: getProportionateScreenHeight(25),
          ),
          Text(
            "or using",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kTextLightColor,
            ),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SocialCard(
                icon: "lib/icons/facebook.png",
                press: () {},
              ),
              SocialCard(
                icon: "lib/icons/google.png",
                press: () {},
              ),
              SocialCard(
                icon: "lib/icons/instagram.png",
                press: () {},
              ),
            ],
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
            color: kTextLightColor,
          ),
          decoration: InputDecoration(
            labelText: "Email",
            labelStyle: TextStyle(
              color: kTextLightColor,
            ),
            hintText: "Enter your email",
            hintStyle: TextStyle(
              color: kTextLightColor,
              fontWeight: FontWeight.w300,
              fontSize: 14
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          )
        );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
          obscureText: true,
          onSaved:(newValue) => password = newValue!,
          style: TextStyle(
            color: kTextLightColor,
          ),
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(
              color: kTextLightColor,
            ),
            hintText: "Enter your password",
            hintStyle: TextStyle(
              color: kTextLightColor,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          )
        );
  }

  TextFormField buildConfirmPwFormField() {
    return TextFormField(
          obscureText: true,
          onSaved:(newValue) => confirm_password = newValue!,
          style: TextStyle(
            color: kTextLightColor,
          ),
          decoration: InputDecoration(
            labelText: "Confirm Password",
            labelStyle: TextStyle(
              color: kTextLightColor,
            ),
            hintText: "Re-enter your password",
            hintStyle: TextStyle(
              color: kTextLightColor,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          )
        );
  }
}
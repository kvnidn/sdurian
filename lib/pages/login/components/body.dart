import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/constants.dart';
import 'package:sdurian/size_config.dart';

import '../../../components/no_account.dart';
import 'login_form.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      width: double.infinity,
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: getProportionateScreenHeight(30)),
              Container(
                height: getProportionateScreenHeight(72.15),
                width: getProportionateScreenWidth(66),
                child: Image.asset(
                  "lib/assets/durianking.png",
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(20)),
              Text(
                "Welcome Back",
                style: headingStyle,
              ),
              SizedBox(height: getProportionateScreenHeight(10)),
              Text(
                "Log in with your email and password",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
              SizedBox(height: getProportionateScreenHeight(25)),
              LogInForm(),
              // SizedBox(height: getProportionateScreenHeight(25)),
              // Text(
              //   "or using",
              //   textAlign: TextAlign.center,
              //   style: TextStyle(
              //     color: kTextLightColor,
              //   ),
              // ),
              // SizedBox(height: getProportionateScreenHeight(25)),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     SocialCard(
              //       icon: "lib/icons/facebook.png",
              //       press: () {},
              //     ),
              //     SocialCard(
              //       icon: "lib/icons/google.png",
              //       press: () {},
              //     ),
              //     SocialCard(
              //       icon: "lib/icons/instagram.png",
              //       press: () {},
              //     ),
              //   ],
              // ),
              SizedBox(height: getProportionateScreenHeight(30)),
              noAccount(),
              SizedBox(height: getProportionateScreenHeight(38)),
            ],
          ),
        ),
      ),
    ));
  }
}

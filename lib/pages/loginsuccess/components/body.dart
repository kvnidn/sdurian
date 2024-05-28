import 'package:flutter/material.dart';
import 'package:sdurian/constants.dart';
import 'package:sdurian/size_config.dart';

import '../../../components/default_button.dart';
import 'package:sdurian/navbar.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "lib/icons/verified.png",
            height: SizeConfig.screenHeight * 0.22,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.08,
          ),
          Text("Login Success",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: kPrimaryColor,
              )),
          SizedBox(
            height: SizeConfig.screenHeight * 0.08,
          ),
          DefaultButton(
            text: "Let's explore!",
            press: () {
              Navigator.pushNamed(context, NavBar.routeName);
            },
          ),
        ],
      ),
    );
  }
}
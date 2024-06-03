import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/constants.dart';
import 'package:sdurian/pages/login/login.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/utils/constants/sizes.dart';

import '../../../components/default_button.dart';

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
            "lib/assets/verified.gif",
            height: SizeConfig.screenHeight * 0.28,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.04,
          ),
          Text("Congratulations! You're in!",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              )),
          SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          const Text(
            "Get ready to indulge in entertainment\nand flavors like never before!\nYour journey of fun and flavor starts now!",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xFF191716),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: SizeConfig.screenHeight * 0.08,
          ),
          DefaultButton(
            text: "Log in now!",
            press: () {
              Navigator.pushNamed(context, LogInScreen.routeName);
            },
          ),
        ],
      ),
    );
  }
}

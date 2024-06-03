import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/constants.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/utils/constants/sizes.dart';

import '../../../components/default_button.dart';
import 'package:sdurian/navbar.dart';

class Body extends StatelessWidget {
  final User user;
  const Body({super.key, required this.user});

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
          Text("Login Success!",
              style: TextStyle(
                fontSize: getProportionateScreenWidth(30),
                fontWeight: FontWeight.bold,
                color: TColors.primary,
              )),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          const Text(
            "Get ready to dive into a world of exciting\nentertainment and delicious flavors.\nYour next great experience is just a tap away!",
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
            text: "Let's explore!",
            press: () {
              // Navigator.pushNamed(context, NavBar.routeName);
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NavBar(user: user)));
            },
          ),
        ],
      ),
    );
  }
}

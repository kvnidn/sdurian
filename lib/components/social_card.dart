import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/constants.dart';

import '../size_config.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({
    super.key,
    required this.icon,
    required this.press,
  });

  final String icon;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: getProportionateScreenWidth(10),
      ),
      padding: EdgeInsets.all(getProportionateScreenWidth(12)),
      height: getProportionateScreenHeight(40),
      width: getProportionateScreenWidth(40),
      decoration: BoxDecoration(
        color: TColors.primary,
        shape: BoxShape.circle,
      ),
      child: Image.asset(icon),
    );
  }
}

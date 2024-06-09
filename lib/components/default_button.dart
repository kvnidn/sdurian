import 'package:flutter/material.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/utils/constants/colors.dart';

class DefaultButton extends StatelessWidget {
  const DefaultButton({
    super.key,
    this.text,
    this.press,
    this.isPrimary = true,
  });
  final String? text;
  final Function? press;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: getProportionateScreenWidth(135),
      height: getProportionateScreenHeight(40),
      child: TextButton(
        style: TextButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          foregroundColor: Colors.white,
          backgroundColor: isPrimary ? TColors.primary : TColors.primary,
        ),
        onPressed: press as void Function()?,
        child: Text(
          text!,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(15),
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
// import 'package:sdurian/utils/constants/constants.dart';
import 'package:sdurian/size_config.dart';

class FormError extends StatelessWidget {
  const FormError({
    super.key,
    required this.errors,
  });

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index])),
    );
  }

  Row formErrorText({required String error}) {
    return Row(children: [
      Image.asset(
        "lib/icons/Error.png",
        height: getProportionateScreenHeight(14),
        width: getProportionateScreenWidth(14),
      ),
      SizedBox(
        width: getProportionateScreenWidth(10),
      ),
      Text(
        error,
        style: TextStyle(
          color: Colors.black,
        ),
      ),
    ]);
  }
}

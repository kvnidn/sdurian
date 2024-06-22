import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';

class TTextFieldTheme {
  TTextFieldTheme._(); // To prevent creating instances

  static InputDecorationTheme inputDecorationTheme() {
    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(color: TColors.primary),
      gapPadding: 10,
    );
    return InputDecorationTheme(
      contentPadding: EdgeInsets.symmetric(
        horizontal: 28,
        vertical: 15,
      ),
      enabledBorder: outlineInputBorder,
      focusedBorder: outlineInputBorder,
      border: outlineInputBorder,
    );
  }
}

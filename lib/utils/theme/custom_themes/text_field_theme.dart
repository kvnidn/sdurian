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

  // static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  //   errorMaxLines: 3,
  //   prefixIconColor: Colors.grey,
  //   suffixIconColor: Colors.grey,
  //   // constraints: const BoxConstraints.expand(height: 14.inputFieldHeight),
  //   labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
  //   hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
  //   errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
  //   floatingLabelStyle:
  //       const TextStyle().copyWith(color: Colors.black.withOpacity(0.8)),
  //   border: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(width: 1, color: Colors.grey),
  //   ),
  //   enabledBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(width: 1, color: Colors.grey),
  //   ),
  //   focusedBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(width: 1, color: Colors.black12),
  //   ),
  //   errorBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(width: 1, color: Colors.red),
  //   ),
  //   focusedErrorBorder: const OutlineInputBorder().copyWith(
  //     borderRadius: BorderRadius.circular(14),
  //     borderSide: const BorderSide(width: 2, color: Colors.orange),
  //   ),
  // );
}

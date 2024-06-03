import 'package:flutter/material.dart';

class TChipTheme {
  TChipTheme._(); // To prevent creating instances

  static ChipThemeData poodakChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Color(0xFF191716)),
    selectedColor: Color(0xFFFFCA40),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );

  static ChipThemeData ussChipTheme = ChipThemeData(
    disabledColor: Colors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: Color(0xFF191716)),
    selectedColor: Color(0xFF006FFD),
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
    checkmarkColor: Colors.white,
  );
}

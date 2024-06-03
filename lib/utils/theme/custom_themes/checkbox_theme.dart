import 'package:flutter/material.dart';

class TCheckboxTheme {
  TCheckboxTheme._(); // To avoid creating instances

  // Customizable Poodak Text Theme
  static CheckboxThemeData poodakCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFFFFCA40);
      } else {
        return Colors.transparent;
      }
    }),
  );

  // Customizable USS Text Theme
  static CheckboxThemeData ussCheckboxTheme = CheckboxThemeData(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    checkColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Colors.white;
      } else {
        return Colors.black;
      }
    }),
    fillColor: MaterialStateProperty.resolveWith((states) {
      if (states.contains(MaterialState.selected)) {
        return Color(0xFF006FFD);
      } else {
        return Colors.transparent;
      }
    }),
  );
}

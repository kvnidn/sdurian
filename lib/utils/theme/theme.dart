import 'package:flutter/material.dart';
import 'package:sdurian/utils/theme/custom_themes/appbar_theme.dart';
import 'package:sdurian/utils/theme/custom_themes/bottom_sheet_theme.dart';
import 'package:sdurian/utils/theme/custom_themes/checkbox_theme.dart';
import 'package:sdurian/utils/theme/custom_themes/chip_theme.dart';
import 'package:sdurian/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:sdurian/utils/theme/custom_themes/outlined_button_theme.dart';
import 'package:sdurian/utils/theme/custom_themes/text_field_theme.dart';
import 'package:sdurian/utils/theme/custom_themes/text_theme.dart';

class TAppTheme {
  TAppTheme._(); // To avoid creating instances

  // Poodak Theme
  static ThemeData poodakTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Color(0xFFFFCA40),
    textTheme: TTextTheme.textTheme,
    chipTheme: TChipTheme.poodakChipTheme,
    scaffoldBackgroundColor: Color(0xFFF8F8F7),
    appBarTheme: TAppBarTheme.appBarTheme,
    checkboxTheme: TCheckboxTheme.poodakCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.bottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.poodakElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.poodakOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.inputDecorationTheme(),
  );

  // USS Theme
  static ThemeData ussTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: Color(0xFF006FFD),
    textTheme: TTextTheme.textTheme,
    chipTheme: TChipTheme.ussChipTheme,
    scaffoldBackgroundColor: Color(0xFFF8F8F7),
    appBarTheme: TAppBarTheme.appBarTheme,
    checkboxTheme: TCheckboxTheme.ussCheckboxTheme,
    bottomSheetTheme: TBottomSheetTheme.bottomSheetTheme,
    elevatedButtonTheme: TElevatedButtonTheme.ussElevatedButtonTheme,
    outlinedButtonTheme: TOutlinedButtonTheme.ussOutlinedButtonTheme,
    inputDecorationTheme: TTextFieldTheme.inputDecorationTheme(),
  );
}

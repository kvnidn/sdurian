import 'package:flutter/material.dart';

class TBottomSheetTheme {
  TBottomSheetTheme._(); // To avoid creating instances

  static BottomSheetThemeData bottomSheetTheme = BottomSheetThemeData(
    showDragHandle: true,
    backgroundColor: Colors.white,
    modalBackgroundColor: Colors.white,
    constraints: const BoxConstraints(minWidth: double.infinity),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  );
}

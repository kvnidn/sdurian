import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdurian/pages/onboarding/screen/onboarding.dart';
import 'package:sdurian/utils/theme/theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: ThemeMode.light,
      theme: TAppTheme.poodakTheme,
      home: const OnBoardingScreen(),
    );
  }
}

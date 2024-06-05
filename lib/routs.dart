import 'package:flutter/widgets.dart';
import 'package:sdurian/pages/onboarding/screen/onboarding.dart';
import 'package:sdurian/pages/splash/splash_screen.dart';
import 'package:sdurian/pages/login/login.dart';
import 'package:sdurian/pages/forgotpw/forgotpw.dart';
import 'package:sdurian/pages/signup/signup.dart';
import 'package:sdurian/pages/signupsuccess/signupscs.dart';

final Map<String, WidgetBuilder> routes = {
  OnBoardingScreen.routeName: (context) => OnBoardingScreen(),
  SplashScreen.routeName: (context) => SplashScreen(),
  LogInScreen.routeName: (context) => LogInScreen(),
  ForgotPwScreen.routeName: (context) => ForgotPwScreen(),
  // LogInScsScreen.routeName: (context) => LogInScsScreen(),
  SignUpScreen.routeName: (context) => SignUpScreen(),
  // CompleteProfileScreen.routeName: (context) => CompleteProfileScreen(),
  SignUpScsScreen.routeName: (context) => SignUpScsScreen(),
  // NavBar.routeName:(context) => NavBar(),
};

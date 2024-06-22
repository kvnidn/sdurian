import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/onboarding/screen/onboarding.dart';
import 'package:sdurian/routs.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/utils/theme/theme.dart';
import 'package:change_app_package_name/change_app_package_name.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  ShopItem.fetchData("poodak");
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: TAppTheme.poodakTheme,
      initialRoute: OnBoardingScreen.routeName,
      routes: routes,
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sdurian/pages/data.dart';
import 'package:sdurian/pages/splash/splash_screen.dart';
import 'package:sdurian/routs.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/constants.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());

  // ShopItem.replaceBackslashInField('poodak', 'imgPath');
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
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

// ThemeData theme() {
//   return ThemeData(
//     fontFamily: "Poppins",
//   );
// }

ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    unselectedWidgetColor: Colors.black,
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    inputDecorationTheme: inputDecorationTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

InputDecorationTheme inputDecorationTheme() {
  OutlineInputBorder outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(24),
    borderSide: BorderSide(color: kPrimaryColor),
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

TextTheme textTheme() {
  return TextTheme(
    bodyText1: TextStyle(color: kTextColor),
    bodyText2: TextStyle(color: kTextColor),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
      color: kPrimaryColor,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Color(0XFFF8F9FA),
        fontSize: 18,
        fontFamily: "Poppins",
        fontWeight: FontWeight.w700,
      ));
}

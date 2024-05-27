import 'package:flutter/material.dart';
import 'package:sdurian/routs.dart';
import 'package:sdurian/pages/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}

ThemeData theme() {
  return ThemeData(
    fontFamily: "Poppins",
  );
}
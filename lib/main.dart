import 'package:flutter/material.dart';
import 'package:sdurian/navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OpeningPage(),
      theme: theme(),
    );
  }
}

class OpeningPage extends StatefulWidget {
  const OpeningPage({Key? key}) : super(key: key);

  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SafeArea(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Universal\nPoodak Studio",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFFFBF00),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "lib/assets/durian_king.png",
                    width: 300,
                    height: 300,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      "We provide the most unique experience with combination of vehicle and durian",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to a different page
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => NavBar()),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFFFBF00),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      width: 200,
                      height: 50,
                      child: Center(
                        child: Text(
                          "Let's explore!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: Colors.black,
                        ),
                        children: _buildDeveloperText(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }



  List<TextSpan> _buildDeveloperText() {
    return [
      TextSpan(text: "Developed by "),
      _highlightedText("SDurian\n"),
      _highlightedText("JASON"),
      _normalText("Permana"),
      _highlightedText("ARYA"),
      _normalText("Wira Kristanto"),
      _highlightedText("DEVIN"),
      _normalText("Saputra Wijaya \n"),
      _highlightedText("NICHOLAS"),
      _normalText("Martin"),
      _highlightedText("KEVIN"),
      _normalText("Jonathan JM"),
    ];
  }

  TextSpan _highlightedText(String text) {
    return TextSpan(
      text: text + " ",
      style: TextStyle(
        fontSize: 14,
        color: Color(0xFFFFBF00),
        fontWeight: FontWeight.bold,
      ),
    );
  }

  TextSpan _normalText(String text) {
    return TextSpan(
      text: text + " ",
      style: TextStyle(
        fontSize: 10,
      ),
    );
  }
}


ThemeData theme() {
  return ThemeData(
    fontFamily: "Poppins",
  );
}
import 'package:flutter/material.dart';
import 'package:sdurian/authentication.dart';
import 'package:sdurian/navbar.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/login/login.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool _isLoggedIn = false;

  User? user;

  Future<void> _loadUserData() async {
    try {
      String? email = await Auth().fetchEmail();
      if (email != null) {
        print(email.toString());
        await User.fetchUserByEmail(email).then((_) {
          setState(() {
            user = User.currentUser.isNotEmpty ? User.currentUser.first : null;
          });
        });
      }
    } catch (e) {
      print('Error loading user data: $e');
      // Handle error (e.g., navigate to login screen, show error message, etc.)
    }
    await checkLoggedInStatus();
  }

  @override
  void initState() {
    super.initState();
    // Check authentication state when the widget initializes
    _loadUserData();
    // checkLoggedInStatus();
  }

  // Function to check authentication state
  Future<void> checkLoggedInStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final authToken = prefs.getString('email');
    setState(() {
      _isLoggedIn = authToken != null;
    });
    print(user?.email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                color: TColors.primary,
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
                "We provide the most unique experience\nwith combination of vehicle and durian",
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
                // Auth().logout();
                // Navigate based on authentication state
                if (_isLoggedIn && user != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => NavBar(user: user!)),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LogInScreen()),
                  );
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  color: TColors.primary,
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

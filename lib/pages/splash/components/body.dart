import 'package:flutter/material.dart';
import 'package:sdurian/navbar.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
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
            )
          ],
        ),
      ),
    );
  }
}
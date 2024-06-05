import 'package:flutter/material.dart';
import 'package:sdurian/pages/cart_poodak.dart';
import 'package:sdurian/pages/cart_uss.dart';
import 'package:sdurian/data.dart';

class Cart extends StatefulWidget {
  final User user;
  const Cart({Key? key, required this.user}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: SafeArea(
            child: Container(
          child: Column(children: [
            // Text(
            //   "Check your order details",
            //   style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            // ),
            _buildGreeting(),
            _buildCartCategory("lib/assets/poodak.jpeg", "Poodak's Cart",
                CartPoodak(user: widget.user)),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "OR",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            _buildCartCategory(
                "lib/assets/uss.jpg",
                "USS's Cart",
                CartUSS(
                  user: widget.user,
                )),
          ]),
        )),
      )),
    );
  }

  Widget _buildGreeting() {
    return Container(
      // constraints: BoxConstraints(maxWidth: 280),
      alignment: Alignment.center,
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.asset(
          "lib/assets/durian_king.png",
          width: 150,
          height: 150,
        ),
        Text(
          "Check your order\ndetails here",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ]),
    );
  }

  Widget _buildCartCategory(String imagePath, String name, Widget destination) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(20), boxShadow: [
        BoxShadow(
          color: Colors.black
              .withOpacity(0.4), // Lighter shadow for a softer effect
          blurRadius: 5,
          spreadRadius: 3, // Optional: makes the shadow slightly bigger
          offset: Offset(0, 5), // Position the shadow (x, y)
        ),
      ]),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => destination));
        },
        child: Stack(children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 360,
              height: 230,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Color(0xFFFFBF00),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(30),
                  )),
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

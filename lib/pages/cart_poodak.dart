import 'package:flutter/material.dart';

class CartPoodak extends StatefulWidget {
  const CartPoodak({Key? key}) : super(key: key);

  @override
  State<CartPoodak> createState() => _CartPoodakState();
}

class _CartPoodakState extends State<CartPoodak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFFBF00),
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: Colors.black), // Change arrow color here
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          "Poodak's Cart",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.history,
                color: Colors.black), // Replace with your desired icon
            onPressed: () {
              // Add your onPressed code here
            },
          ),
        ],
      ),
      body: SafeArea(
          child: Center(
        child: SafeArea(
            child: Container(
          child: Column(children: []),
        )),
      )),
    );
  }

  Widget _buildItemCard(
      String imagePath, String name, String price, String amount) {
    return Container();
  }
}

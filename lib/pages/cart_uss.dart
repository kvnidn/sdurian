import 'package:flutter/material.dart';

class CartUSS extends StatefulWidget {
  const CartUSS({Key? key}) : super(key: key);

  @override
  State<CartUSS> createState() => _CartUSSState();
}

class _CartUSSState extends State<CartUSS> {
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
          "USS's Cart",
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
}

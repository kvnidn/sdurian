import 'package:flutter/material.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/components/default_button.dart';

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
        backgroundColor: const Color(0xFFFFBF00),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,
              color: Colors.black), // Change arrow color here
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          "Poodak's Cart",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.history,
                color: Colors.black), // Replace with your desired icon
            onPressed: () {
              // Add your onPressed code here
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItemCard(
              "lib/assets/PoodakMenu/DurianDessert/EsDurianMochiJumbo.webp",
              "Es Durian Mochi Jumbo",
              49000,
              1,
            ),
            _checkoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(
      String imagePath, String name, double price, int amount) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.only(top: 14),
      width: 360,
      height: 100,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 5,
            spreadRadius: 1,
            offset: Offset(0, 0.5),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align all text content to the left
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12, top: 2),
                // Center the image horizontally
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    width: 75,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 2.0), // Add padding for better layout
                child: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 16, // Adjusted font size
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 28),
                    // Add space between text
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              amount--;
                            });
                          },
                          child: Icon(Icons.remove_circle),
                        ),
                        SizedBox(width: 10),
                        Text('${amount}',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500)),
                        SizedBox(width: 10),
                        InkWell(
                          onTap: () {
                            setState(() {
                              amount++;
                            });
                          },
                          child: Icon(Icons.add_circle),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Text(
              'Rp ${price.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 16, // Adjusted font size
                fontWeight: FontWeight.bold,
                color: Colors.green, // Optional: color for price
              ),
            ),
          ),
          Positioned(
            top: 2,
            right: 10,
            child: Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(9),
              ),
              child: Center(
                child: Icon(
                  Icons.delete_forever_outlined,
                  size: 24,
                  color: Colors.redAccent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _checkoutButton() {
    return Container(
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: getProportionateScreenHeight(120),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 4,
                  spreadRadius: 4,
                  offset: Offset(0, -1),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0), // Add padding here
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: 16.0, bottom: 20.0), // Add margin to total price
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Price:',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        'Rp 49.000',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 16.0), // Add margin to button
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: DefaultButton(
                    text: "Checkout",
                    press: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/components/default_button.dart';

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildItemCard(
              "Holiday in Universal Studio Singapore",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus laoreet, mauris eu efficitur ullamcorper, nunc elit maximus justo, lacinia finibus dui tellus ut felis.",
              123000,
              1,
            ),
            _checkoutButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard(
      String topic, String description, double price, int amount) {
    return Container(
      padding: EdgeInsets.only(top: 10),
      margin: EdgeInsets.all(18),
      width: 360,
      height: 120,
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
            children: [
              Container(
                constraints:
                    BoxConstraints(maxWidth: 250), // Set maximum width here
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 2.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            topic,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          SizedBox(height: 2),
                          Container(
                            child: Text(
                              description,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 3,
                            ),
                          ),
                          // Add space between text
                          Text(
                            "Lihat Detail",
                            style: TextStyle(
                              color: Color(0xFFFFBF00),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 6), // Add space between columns
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.end, // Align elements to the end
                    children: [
                      Positioned(
                        top: 2,
                        right: 10,
                        child: Center(
                          child: Icon(
                            Icons.delete_forever_outlined,
                            size: 24,
                            color: Colors.redAccent,
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                amount--;
                              });
                            },
                            child: const Icon(
                              Icons.remove,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text('${amount}',
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.w500)),
                          const SizedBox(width: 8),
                          InkWell(
                            onTap: () {
                              setState(() {
                                amount++;
                              });
                            },
                            child: const Icon(
                              Icons.add,
                              size: 22,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'Rp ${price.toStringAsFixed(0)}',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ],
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
                        'Rp 123 .000',
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

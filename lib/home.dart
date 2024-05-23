import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        constraints: const BoxConstraints(maxWidth: 600),
        child: SafeArea(
          child:
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, 
              children: [
                _buildCategoryHeader("Category"),
                _buildCategory(),
              ]
            ),
          ),
        )
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Container(
      margin: EdgeInsets.only(left: 20),
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  Widget _buildCategory() {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Adjust the radius as needed
                child: Image.asset(
                  "lib/assets/uss.jpg",
                  width: 170,
                  height: 100,
                  fit: BoxFit.cover, // Ensure the image covers the entire space
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.5), // Add a semi-transparent background
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    "USS",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(width: 20),
          Stack(
            children: [
              ClipRRect(
                borderRadius:
                    BorderRadius.circular(20), // Adjust the radius as needed
                child: Image.asset(
                  "lib/assets/poodak.jpeg",
                  width: 170,
                  height: 100,
                  fit: BoxFit.cover, // Ensure the image covers the entire space
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black
                        .withOpacity(0.5), // Add a semi-transparent background
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Text(
                    "Poodak",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

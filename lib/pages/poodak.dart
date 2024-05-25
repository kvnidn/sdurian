import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Poodak extends StatefulWidget {
  const Poodak({Key? key}) : super(key: key);

  @override
  State<Poodak> createState() => _PoodakState();
}

class _PoodakState extends State<Poodak> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center, // Aligns children at the start
              children: [
                Column( // Container for "Categories" text
                  crossAxisAlignment: CrossAxisAlignment.start, // Aligns children at the start
                  children: [
                    _buildOfferCarousel([
                      _buildOffers("Special Deals 1", "lib/assets/poodak.jpeg"),
                      _buildOffers("Special Deals 2", "lib/assets/poodak.jpeg"),
                      _buildOffers("Special Deals 3", "lib/assets/poodak.jpeg"),
                  ]),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                  ],
                ),    
                SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _buildCategory("Ice Cream"),
                      _buildCategory("Ice Cream"),
                      _buildCategory("Ice Cream"),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOffers(String offer, String imagePath) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Stack(
        children: [
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
            bottom: 10,
            left: 10,
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(10), // Adjust border radius as needed
              ),
              child: Text(
                offer,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildOfferCarousel(List<Widget> offers) {
  return Container(
    child: CarouselSlider.builder(
      itemCount: offers.length,
      options: CarouselOptions(
        autoPlay: true,
        viewportFraction: 1.0,
      ),
      itemBuilder: (context, index, realIndex) {
        return offers[index];
      },
    ),
  );
}



  Widget _buildCategory(String name) {
  return Container(
    margin: EdgeInsets.only(left: 15, right: 15),
    decoration: BoxDecoration(
      color: Color(0xFFFFBF00),
      borderRadius: BorderRadius.circular(15),
    ),
    padding: EdgeInsets.symmetric(horizontal: 30),
    alignment: Alignment.center,
    height: 50,
    child: IntrinsicWidth(
      child: Text(
        name,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ),
  );
}

}

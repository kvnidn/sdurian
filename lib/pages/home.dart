import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/profile.dart';
import 'package:sdurian/size_config.dart';

class Home extends StatefulWidget {
  final User user;
  final Function(int) onTabSelected;
  const Home({Key? key, required this.user, required this.onTabSelected})
      : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  DateTime today = DateTime.now();
  String dateFormat = 'dd MMM yyyy';

  int adjustPrice(double price, bool isWeekend) {
    if (isWeekend) {
      return (1.5 * price).toInt();
    } else {
      return price.toInt();
    }
  }

  bool isWeekend(DateTime date) {
    return date.weekday == DateTime.saturday || date.weekday == DateTime.sunday;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xFFFFBF00),
        title: Padding(
          padding: const EdgeInsets.only(
              left: 5.0), // Adjust the left padding as needed
          child: Text(
            "Hi, " + widget.user.username,
            style: TextStyle(
              color: Colors.black,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
                right: 15.0), // Adjust the right padding as needed
            child: IconButton(
              icon: const Icon(Icons.settings, color: Colors.black),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Profile(user: widget.user)),
                );
              },
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Category section, USS or Poodak
            Expanded(
                child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    // constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: _buildCategoryHeader("Categories"),
                        ),
                        _buildCategory(),
                        SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child:
                              _buildCategoryHeader("Today's Recommendations"),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: _buildCategorySubHeader("Poodak", 1),
                        ),
                        _buildPoodakList(ShopItem.shopItemsRekomendasi),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: _buildCategorySubHeader("USS", 2),
                        ),
                        Container(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              _buildTabContent(
                                  "Ticket A, ${DateFormat(dateFormat).format(today.add(Duration(days: 0)))}",
                                  "Standard Adult",
                                  adjustPrice(150000,
                                      isWeekend(today.add(Duration(days: 0))))),
                              _buildTabContent(
                                  "Ticket B, ${DateFormat(dateFormat).format(today.add(Duration(days: 0)))}",
                                  "Standard Children",
                                  adjustPrice(100000,
                                      isWeekend(today.add(Duration(days: 0))))),
                              _buildTabContent(
                                  "Ticket C, ${DateFormat(dateFormat).format(today.add(Duration(days: 0)))}",
                                  "Family Pack (up to 4 people)",
                                  adjustPrice(300000,
                                      isWeekend(today.add(Duration(days: 0))))),
                            ],
                          ),
                        ),
                      ],
                    ))),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Container(
      child: Text(
        'Hi, ${widget.user.username}',
        style: TextStyle(
          color: Colors.black,
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.yellow[300],
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Row(
        children: [
          Icon(Icons.search),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search',
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                hintStyle: TextStyle(color: Colors.black),
              ),
              style: TextStyle(color: Colors.black),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildCategorySubHeader(String title, int index) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        GestureDetector(
            onTap: () {
              widget.onTabSelected(index);
            },
            child: Row(
              children: [
                Text(
                  "See More ",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  ">",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ))
      ],
    ));
  }

  // Category
  Widget _buildCategory() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryItem("Poodak", "lib/assets/poodak.jpeg", 1),
          _buildCategoryItem("USS", "lib/assets/uss.jpg", 2),
        ],
      ),
    );
  }

  // Category Item
  Widget _buildCategoryItem(String title, String imagePath, int index) {
    return InkWell(
      // Navigation Link
      onTap: () {
        widget.onTabSelected(index);
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: 180,
              height: 110,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                  color: Color(0xFFFFBF00),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    topRight: Radius.circular(30),
                  )),
              child: Text(
                title,
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

  Widget _buildPoodakCard(String imagePath, String name, double price,
      String description, String email) {
    // Create a NumberFormat instance
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 2,
    );

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      padding: EdgeInsets.only(top: 10),
      width: 190,
      height: 250, // Adjusted height to fit the text properly
      decoration: BoxDecoration(
        color: Colors.white, // Ensure the container has a background color
        borderRadius:
            BorderRadius.circular(20), // Match the border radius of the image
        boxShadow: [
          BoxShadow(
            color: Colors.black
                .withOpacity(0.2), // Lighter shadow for a softer effect
            blurRadius: 5,
            spreadRadius: 1, // Optional: makes the shadow slightly bigger
            offset: Offset(0, 0.5), // Position the shadow (x, y)
          ),
        ],
      ),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align all text content to the left
            children: [
              Center(
                // Center the image horizontally
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    imagePath,
                    width: 150,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 8.0), // Add padding for better layout
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
                    SizedBox(height: 4), // Add space between text
                    Text(
                      currencyFormatter.format(price),
                      style: TextStyle(
                        fontSize: 16, // Adjusted font size
                        fontWeight: FontWeight.bold,
                        color: Colors.green, // Optional: color for price
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: Size(40, 40),
                padding: EdgeInsets.zero,
              ),
              onPressed: () {
                CartItem.addItemToPoodakCart(
                  imgPath: imagePath,
                  name: name,
                  price: price,
                  description: description,
                  amount: 1.0,
                  email: email, //Set as 1 for now
                );
              },
              child: Icon(
                Icons.add_shopping_cart,
                size: 24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoodakList(List<ShopItem> items) {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10.0),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Transform.translate(
            offset: Offset(0.0, 0.0),
            child: _buildPoodakCard(
                items[index].imgPath,
                items[index].name,
                items[index].price,
                items[index].description,
                widget.user.email),
          );
        },
      ),
    );
  }

  Widget _buildTabContent(String topic, String description, int price) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 2,
    );

    return Container(
      margin: EdgeInsets.all(10),
      width: 380,
      height: 140,
      decoration: BoxDecoration(color: Colors.white, boxShadow: [
        BoxShadow(
          color: Colors.grey,
          blurRadius: 5.0,
          spreadRadius: 1.0,
          offset: Offset(0, 4.0),
        ),
      ]),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  topic,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 5,
            // left: 10,

            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () {},
              child: Text(
                "See Details",
                style: TextStyle(
                  color: Color(0xFFFFBF00),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            right: 8.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  currencyFormatter.format(price),
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFFFBF00),
                  ),
                  onPressed: () {
                    CartItemUSS.addItemToCart(
                        name: topic,
                        price: price.toDouble(),
                        description: description,
                        amount: 1.0,
                        email: widget.user.email);
                  },
                  child: Text("Buy ticket"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

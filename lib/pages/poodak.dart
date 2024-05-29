import 'package:carousel_slider/carousel_slider.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:sdurian/pages/data.dart';

class Poodak extends StatefulWidget {
  const Poodak({Key? key}) : super(key: key);

  @override
  State<Poodak> createState() => _PoodakState();
}

class _PoodakState extends State<Poodak> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<List<ShopItem>> poodakItems = ShopItem.combinedList;
  List<String> categoryNames = [
    "Dessert",
    "Dooren",
    "Paket Nasi",
    "Snack",
  ];

  @override
  void initState() {
    ShopItem.fetchData("poodak");
    super.initState();
    _tabController = TabController(length: poodakItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildOfferCarousel([
                      _buildOffers("Special Deals 1", "lib/assets/poodak.jpeg"),
                      _buildOffers("Special Deals 2", "lib/assets/poodak.jpeg"),
                      _buildOffers("Special Deals 3", "lib/assets/poodak.jpeg"),
                    ]),
                    SizedBox(height: 15),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SliverAppBarDelegate(
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black
                              .withOpacity(0.2), // Shadow color and opacity
                          spreadRadius: 1, // Spread radius
                          blurRadius: 3, // Blur radius
                          offset: Offset(0,
                              3), // Offset from the container (horizontal, vertical)
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      indicator:
                          BoxDecoration(), // Empty box decoration to remove indicator line below tab
                      tabs: <Widget>[
                        for (var i = 0; i < poodakItems.length; i++)
                          Tab(
                            child: _buildCategory(categoryNames[i]),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: <Widget>[
              for (var i = 0; i < poodakItems.length; i++)
                _buildItemList(poodakItems[i]),
            ],
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

  Widget _buildItemCard(String imagePath, String name, double price) {
    // Create a NumberFormat instance
    final NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 2,
    );

    return Container(
      padding: EdgeInsets.only(top: 10),
      width: 170,
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
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Icon(
                  Icons.add_shopping_cart,
                  size: 24,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildItemList(List<ShopItem> items) {
    return GridView.builder(
      padding: EdgeInsets.all(10.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Max 2 items per row
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio:
            0.68, // Adjust this ratio to fit your card height/width
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return _buildItemCard(
          items[index].imgPath,
          items[index].name,
          items[index].price,
        );
      },
      shrinkWrap: true,
      physics:
          NeverScrollableScrollPhysics(), // Prevent the grid from scrolling
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate({
    required this.child,
  });

  final Widget child;

  @override
  double get minExtent => child.preferredSize.height;
  @override
  double get maxExtent => child.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

extension on Widget {
  Size get preferredSize => (this is PreferredSizeWidget)
      ? (this as PreferredSizeWidget).preferredSize
      : Size(double.infinity, kToolbarHeight);
}

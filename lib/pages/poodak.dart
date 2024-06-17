import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:sdurian/components/CarouselBuilder/carousel.dart';
import 'package:sdurian/components/product_card_vertical.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/detail/detail_screen.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/image_strings.dart';
import 'package:sdurian/utils/constants/sizes.dart';

class Poodak extends StatefulWidget {
  final User user;
  const Poodak({Key? key, required this.user}) : super(key: key);

  @override
  State<Poodak> createState() => _PoodakState();
}

class _PoodakState extends State<Poodak> with TickerProviderStateMixin {
  late TabController _tabController;
  late List<List<ShopItem>> poodakItems = ShopItem.combinedList;
  List<String> categoryIcons = [
    TImages.dessert,
    TImages.dooren,
    TImages.rice,
    TImages.snack,
  ];

  List<String> categoryNames = [
    "Dessert",
    "Dooren",
    "Rice",
    "Snack",
  ];

  @override
  void initState() {
    super.initState();
    // ShopItem.fetchData("poodak");
    _tabController = TabController(length: poodakItems.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: TColors.primary,
              expandedHeight: 280.0, // Adjust as needed
              floating: true,
              pinned: true,
              automaticallyImplyLeading: false,
              flexibleSpace: const FlexibleSpaceBar(
                background: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace, vertical: TSizes.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselPromo(
                        banners: [
                          TImages.banner1,
                          TImages.banner2,
                          TImages.banner3,
                        ],
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),
                    ],
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize:
                    const Size.fromHeight(48.0), // Set the preferred height
                child: Container(
                  color: TColors.primary, // Set your desired background color
                  width: MediaQuery.of(context)
                      .size
                      .width, // Set width to screen size
                  child: Center(
                    child: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelStyle: Theme.of(context).textTheme.titleMedium,
                      indicatorColor: TColors.primary,
                      labelColor: TColors.white,
                      unselectedLabelColor: TColors
                          .darkerGrey, // Set the color for unselected tabs
                      labelPadding: const EdgeInsets.symmetric(
                          horizontal: TSizes.md), // Adjust padding
                      tabs: [
                        for (var i = 0; i < poodakItems.length; i++)
                          Tab(text: categoryNames[i]),
                      ],
                    ),
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
    );
  }

  Widget _buildItemCard(String imagePath, String name, double price,
      String description, String email) {
    return TProductCardVertical(
        imageUrl: imagePath,
        title: name,
        description: description,
        price: price,
        onPressed: () {
          CartItem.addItemToPoodakCart(
            imgPath: imagePath,
            name: name,
            price: price,
            description: description,
            amount: 1.0,
            email: email, // Set as 1 for now
          );
          ElegantNotification(
            position: Alignment.topCenter,
            animation: AnimationType.fromTop,
            width: 360,
            height: 60,
            description: Text(
              "$name added to cart",
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(fontWeightDelta: 2),
              textAlign: TextAlign.center,
            ),
            icon: const Icon(
              Icons.check_circle,
              color: TColors.primary,
            ),
            progressIndicatorColor: TColors.primary,
          ).show(context);
        });
  }

  Widget _buildItemList(List<ShopItem> items) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: TSizes.md),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Max 2 items per row
        crossAxisSpacing: TSizes.xs,
        mainAxisSpacing: TSizes.spaceBtwItems,
        childAspectRatio:
            0.635, // Adjust this ratio to fit your card height/width
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailsScreen(
                            imgPath: items[index].imgPath,
                            name: items[index].name,
                            price: items[index].price,
                            description: items[index].description,
                            email: widget.user.email,
                          )));
            },
            child: _buildItemCard(
                items[index].imgPath,
                items[index].name,
                items[index].price,
                items[index].description,
                widget.user.email));
      },
      shrinkWrap: true,
      physics:
          const NeverScrollableScrollPhysics(), // Prevent the grid from scrolling
    );
  }
}

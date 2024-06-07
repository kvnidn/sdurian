import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/components/product_card_vertical.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/navbar.dart';
import 'package:sdurian/pages/home/widgets/cart_icon/cart_counter.dart';
import 'package:sdurian/pages/home/widgets/container/primary_header_container.dart';
import 'package:sdurian/pages/home/widgets/home_appbar/appbar.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';
import 'package:sdurian/utils/constants/text_strings.dart';
import 'package:sdurian/utils/device/device_utility.dart';

class Home extends StatefulWidget {
  final User user;
  const Home({Key? key, required this.user}) : super(key: key);

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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            TPrimaryHeaderContainer(
              child: Column(
                children: [
                  const SizedBox(height: TSizes.spaceBtwItems),
                  // -- AppBar --
                  TAppBar(
                    title: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          TTexts.homeAppBarTitle,
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .apply(color: TColors.black),
                        ),
                        _buildGreeting(),
                      ],
                    ),
                    actions: [
                      TCartCounterIcon(
                        onPressed: () {},
                        iconColor: TColors.black,
                      ),
                    ],
                  ),
                  // -- Search Bar --
                  const SizedBox(height: TSizes.smd),
                  _buildSearchBar(),
                  // Category section, USS or Poodak
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Container(
                    constraints: const BoxConstraints(maxWidth: 600),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.symmetric(horizontal: TSizes.lg),
                          child: _buildCategoryHeader("Popular Categories"),
                        ),
                        _buildCategory()
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // -- Body --
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: _buildCategoryHeader("Today's Recommendations"),
            ),
            SizedBox(
              height: TSizes.sm,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace, vertical: TSizes.sm),
              child: _buildCategorySubHeader("Poodak", 1),
            ),
            _buildPoodakList(ShopItem.shopItemsRekomendasi),
            SizedBox(
              height: TSizes.md,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.defaultSpace, vertical: TSizes.sm),
              child: _buildCategorySubHeader("USS", 2),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  _buildTabContent(
                      "Ticket A, ${DateFormat(dateFormat).format(today.add(Duration(days: 0)))}",
                      "Standard Adult",
                      adjustPrice(
                          150000, isWeekend(today.add(Duration(days: 0))))),
                  _buildTabContent(
                      "Ticket B, ${DateFormat(dateFormat).format(today.add(Duration(days: 0)))}",
                      "Standard Children",
                      adjustPrice(
                          100000, isWeekend(today.add(Duration(days: 0))))),
                  _buildTabContent(
                      "Ticket C, ${DateFormat(dateFormat).format(today.add(Duration(days: 0)))}",
                      "Family Pack (up to 4 people)",
                      adjustPrice(
                          300000, isWeekend(today.add(Duration(days: 0))))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGreeting() {
    return Text(
      'Hello, ${widget.user.username}',
      style: Theme.of(context).textTheme.headlineSmall,
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.lg),
      child: Container(
        width: TDeviceUtils.getScreenWidth(context),
        padding: const EdgeInsets.all(TSizes.md),
        decoration: BoxDecoration(
          color: TColors.white,
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          border: Border.all(color: TColors.grey),
        ),
        child: Row(
          children: [
            const Icon(
              Iconsax.search_normal,
              color: TColors.darkerGrey,
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              'Search...',
              style: Theme.of(context).textTheme.bodySmall,
            )
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Container(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildCategorySubHeader(String title, int index) {
    final controller = Get.find<NavbarController>();
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        GestureDetector(
            onTap: () {
              controller.selectedIndex.value = index;
            },
            child: Row(
              children: [
                Text(
                  "See More ",
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  ">",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ))
      ],
    ));
  }

  // Category
  Widget _buildCategory() {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: TSizes.spaceBtwItems, horizontal: TSizes.defaultSpace),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCategoryItem("Poodak", "lib/assets/poodak.jpeg", 1),
          SizedBox(width: TSizes.defaultSpace),
          _buildCategoryItem("USS", "lib/assets/uss.jpg", 3),
        ],
      ),
    );
  }

  // Category Item
  Widget _buildCategoryItem(String title, String imagePath, int index) {
    final controller = Get.find<NavbarController>();

    return InkWell(
      // Navigation Link
      onTap: () {
        controller.selectedIndex.value = index;
      },
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              imagePath,
              width: 160,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              decoration: BoxDecoration(
                color: TColors.black.withOpacity(0.6),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: TColors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPoodakCard(String imagePath, String name, double price,
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
        });
  }

  Widget _buildPoodakList(List<ShopItem> items) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
      color: TColors.white,
      height: 295,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        // padding: EdgeInsets.all(10.0),
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
      symbol: 'Rp',
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

import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdurian/components/TicketBuilder/ticketui.dart';
import 'package:sdurian/components/product_card_vertical.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/detail/detail_screen.dart';
import 'package:sdurian/pages/home/widgets/cart_icon/cart_counter.dart';
import 'package:sdurian/pages/home/widgets/container/primary_header_container.dart';
import 'package:sdurian/pages/home/widgets/home_appbar/appbar.dart';
import 'package:sdurian/search.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';
import 'package:sdurian/utils/constants/text_strings.dart';
import 'package:sdurian/utils/device/device_utility.dart';

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
  String date = 'dd MMM yyyy';

  double adjustPrice(double price, bool isWeekend) {
    if (isWeekend) {
      return 1.5 * price;
    } else {
      return price;
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
                        onPressed: () {
                          widget.onTabSelected(2);
                        },
                        iconColor: TColors.black,
                      ),
                    ],
                  ),
                  // -- Search Bar --
                  const SizedBox(height: TSizes.smd),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SearchBarA(
                                    email: widget.user.email,
                                  )));
                    },
                    child: _buildSearchBar(),
                  ),
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
                        _buildCategory(),
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
              child: _buildCategorySubHeader("USS", 3),
            ),
            Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  _buildTabContent(
                      today.add(Duration(days: 0)),
                      "17.00 WIB",
                      "Ticket of Duos",
                      "2",
                      adjustPrice(
                          80000, isWeekend(today.add(Duration(days: 0))))),
                  _buildTabContent(
                      today.add(Duration(days: 0)),
                      "19.00 WIB",
                      "Night Time Ticket",
                      "2",
                      adjustPrice(
                          90000, isWeekend(today.add(Duration(days: 0))))),
                  _buildTabContent(
                      today.add(Duration(days: 0)),
                      "12.00 WIB",
                      "Family Ticket",
                      "5",
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
              widget.onTabSelected(index);
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
              child: GestureDetector(
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
                child: _buildPoodakCard(
                    items[index].imgPath,
                    items[index].name,
                    items[index].price,
                    items[index].description,
                    widget.user.email),
              ));
        },
      ),
    );
  }

  Widget _buildTabContent(
      DateTime date, String time, String name, String person, double price) {
    return TicketUi(
      date: date,
      time: time,
      name: name,
      person: person,
      price: price,
      onTap: () {
        CartItemUSS.addItemToCart(
          date: date,
          time: time,
          name: name,
          person: person,
          price: price.toDouble(),
          amount: 1.0,
          email: widget.user.email,
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
      },
    );
  }
}

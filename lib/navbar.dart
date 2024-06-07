import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdurian/pages/cart.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/home/home.dart';
import 'package:sdurian/pages/profile.dart';
import 'package:sdurian/pages/settings.dart';
import 'package:sdurian/pages/uss_page.dart';
import 'package:sdurian/pages/poodak.dart';
import 'package:sdurian/utils/constants/colors.dart';

class NavBar extends StatefulWidget {
  User user;
  NavBar({Key? key, required this.user}) : super(key: key);

  static String routeName = "/navbar";

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  Future<void> fetchUserData() async {
    await User.fetchUserByEmail(widget.user.email).then((_) {
      setState(() {
        widget.user = User.currentUser[0];
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // int _index = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavbarController(user: widget.user));

    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) =>
              controller.selectedIndex.value = index,
          backgroundColor: Colors.white,
          indicatorColor: TColors.black.withOpacity(0.15),
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.reserve), label: 'Poodak'),
            NavigationDestination(icon: Icon(Iconsax.bag_2), label: 'Cart'),
            NavigationDestination(icon: Icon(Iconsax.ticket), label: 'USS'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),

      // backgroundColor: Colors.black,
      // body: PageView.builder(
      //   controller: _pageController,
      //   itemCount: screens.length,
      //   onPageChanged: (index) {
      //     setState(() {
      //       _index = index;
      //     });
      //   },
      //   itemBuilder: (context, index) {
      //     return screens[index];
      //   },
      // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: (index) {
      //     setState(() {
      //       _index = index;
      //     });
      //     _pageController.animateToPage(
      //       index,
      //       duration: Duration(milliseconds: 400),
      //       curve: Curves.easeInOut,
      //     );
      //   },
      //   backgroundColor: TColors.primary,
      //   unselectedItemColor: Colors.white70,
      //   selectedItemColor: Colors.white,
      //   currentIndex: _index,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(FontAwesomeIcons.utensils),
      //       label: 'Poodak',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(FontAwesomeIcons.earthAsia),
      //       label: 'USS', // --> Sementara
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(FontAwesomeIcons.cartShopping),
      //       label: 'Cart',
      //     ),
      //   ],
      // ),
    );
  }
}

class NavbarController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;
  final User user;

  NavbarController({required this.user});

  final List<Widget> screens = [];

  @override
  void onInit() {
    screens.addAll([
      Home(user: user),
      Poodak(user: user),
      Cart(user: user),
      USSState(user: user),
      Profile(user: user),
    ]);
    super.onInit();
  }
}

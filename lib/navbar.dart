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

  int _index = 0;
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void setPage(int index) {
    setState(() {
      _index = index;
    });
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      Home(
        user: widget.user,
        onTabSelected: setPage,
      ),
      Poodak(
        user: widget.user,
      ),
      Cart(
        user: widget.user,
      ),
      USSState(
        user: widget.user,
      ),
      Profile(
        user: widget.user,
      )
    ];

    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        itemCount: screens.length,
        onPageChanged: (index) {
          setState(() {
            _index = index;
          });
        },
        itemBuilder: (context, index) {
          return screens[index];
        },
      ),
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 0,
        selectedIndex: _index,
        onDestinationSelected: (index) => setPage(index),
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
    );
  }
}

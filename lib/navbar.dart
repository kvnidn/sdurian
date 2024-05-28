import 'package:flutter/material.dart';
import 'package:sdurian/pages/home.dart';
import 'package:sdurian/pages/login/login.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);
  
  static String routeName = "/navbar";

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _index = 0;
  final PageController _pageController = PageController();
  final List<Widget> screens = [
    Home(),
    Home(),
    Home(),
    LogInScreen()
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _index = index;
          });
          _pageController.animateToPage(
            index,
            duration: Duration(milliseconds: 400),
            curve: Curves.easeInOut,
          );
        },
        backgroundColor: Color(0xFFFFBF00),
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        currentIndex: _index,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

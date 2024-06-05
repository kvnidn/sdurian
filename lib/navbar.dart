import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdurian/pages/cart.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/home.dart';
import 'package:sdurian/pages/login/login.dart';
import 'package:sdurian/pages/uss_page.dart';
import 'package:sdurian/pages/poodak.dart';

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
      USSState(
        user: widget.user,
      ),
      Cart(
        user: widget.user,
      ),
    ];

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
            icon: Icon(FontAwesomeIcons.utensils),
            label: 'Poodak',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.earthAsia),
            label: 'USS',
          ),
          BottomNavigationBarItem(
            icon: Icon(FontAwesomeIcons.cartShopping),
            label: 'Cart',
          ),
        ],
      ),
    );
  }
}

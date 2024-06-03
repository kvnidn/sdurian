import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sdurian/pages/splash/splash_screen.dart';

class OnBoardingController extends GetxController {
  static OnBoardingController get instance => Get.find();

  // Variables
  final pageController = PageController();
  Rx<int> currentPageIndex = 0.obs;

  // Update current index when page scroll
  void updatePageIndicator(index) => currentPageIndex.value = index;

  // Jump to the specific dot selected page
  void dotNavigationClick(index) {
    currentPageIndex.value = index;
    pageController.jumpTo(index);
  }

  // Update current index & jump to next page
  void nextPage(BuildContext context) {
    if (currentPageIndex.value == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SplashScreen()),
      );
    } else {
      int page = currentPageIndex.value + 1;
      pageController.jumpToPage(page);
    }
  }

  // Update current index & jump to the splash screen page
  void skipPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }
}

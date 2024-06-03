import 'package:flutter/material.dart';
import 'package:sdurian/pages/onboarding/controllers/onboarding_controller.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';
import 'package:sdurian/utils/device/device_utility.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingDotNavigation extends StatelessWidget {
  const OnBoardingDotNavigation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = OnBoardingController.instance;

    return Positioned(
      bottom: TDeviceUtils.getBottomNavigationBarHeight() + 100,
      left: MediaQuery.of(context).size.width / 2 - TSizes.defaultSpace,
      child: SmoothPageIndicator(
        controller: controller.pageController,
        // onDotClicked: controller.dotNavigationClick,
        count: 2,
        effect: ExpandingDotsEffect(
            activeDotColor: TColors.primary, dotHeight: 6, dotWidth: 8),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sdurian/pages/onboarding/controllers/onboarding_controller.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';
import 'package:sdurian/utils/device/device_utility.dart';

class OnBoardingNextButton extends StatelessWidget {
  const OnBoardingNextButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: TSizes.defaultSpace,
      bottom: TDeviceUtils.getBottomNavigationBarHeight(),
      child: ElevatedButton(
        onPressed: () => OnBoardingController.instance.nextPage(context),
        style: ElevatedButton.styleFrom(
            shape: const CircleBorder(), backgroundColor: TColors.primary),
        child: const Icon(Icons.navigate_next),
      ),
    );
  }
}

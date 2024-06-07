import 'package:flutter/material.dart';
import 'package:sdurian/pages/onboarding/controllers/onboarding_controller.dart';
import 'package:sdurian/utils/constants/sizes.dart';
import 'package:sdurian/utils/device/device_utility.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: () => OnBoardingController.instance.skipPage(context),
        child: const Text('Skip'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdurian/utils/constants/colors.dart';

class TCartCounterIcon extends StatelessWidget {
  const TCartCounterIcon({
    super.key,
    required this.iconColor,
    required this.onPressed,
  });

  final Color iconColor;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: Icon(
            Iconsax.bag_2,
            color: iconColor,
          ),
        ),
        Positioned(
          right: 8,
          top: 6,
          child: Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: TColors.secondary,
              borderRadius: BorderRadius.circular(100),
            ),
            // child: Center(
            //   child: Text(
            //     '0',
            //     style: Theme.of(context)
            //         .textTheme
            //         .labelLarge!
            //         .apply(color: TColors.white, fontSizeFactor: 0.8),
            //   ),
            // ),
          ),
        )
      ],
    );
  }
}

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
              color: TColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        )
      ],
    );
  }
}

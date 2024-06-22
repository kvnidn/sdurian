import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';

class TCategories extends StatelessWidget {
  const TCategories({
    super.key,
    required this.imageUrl,
    required this.name,
    this.backgroundColor = TColors.white,
    this.onTap,
  });

  final String imageUrl;
  final String name;
  final Color? backgroundColor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(
          children: [
            /// - Circular Icon
            Container(
              width: 56,
              height: 56,
              padding: EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(100),
              ),
              child: Center(
                child: Image(
                  image: AssetImage(imageUrl),
                  fit: BoxFit.cover,
                  color: TColors.dark,
                ),
              ),
            ),

            /// - Text
            SizedBox(height: TSizes.spaceBtwItems / 4),
            Center(
              child: Text(
                name,
                style: Theme.of(context).textTheme.labelMedium,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: TSizes.xs)
          ],
        ),
      ),
    );
  }
}

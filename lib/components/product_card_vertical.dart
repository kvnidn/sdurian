import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sdurian/components/CarouselBuilder/carousel.dart';
import 'package:sdurian/components/widgets/product_price_text.dart';
import 'package:sdurian/components/widgets/product_title_text.dart';
import 'package:sdurian/pages/home/widgets/container/rounded_container.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';
import 'package:sdurian/utils/styles/shadows.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.price,
    this.onPressed,
  });

  final String imageUrl;
  final String title;
  final String description;
  final double price;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: TSizes.sm),
        padding: EdgeInsets.all(0),
        width: 180,
        decoration: BoxDecoration(
          boxShadow: [TShadowStyle.verticalProductShadow],
          borderRadius: BorderRadius.circular(TSizes.productImageRadius),
          color: TColors.white,
        ),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// - Thumbnail
                TRoundedContainer(
                  height: 180,
                  padding: const EdgeInsets.all(TSizes.sm),
                  backgroundColor: TColors.light,
                  child: Stack(
                    children: [
                      // Thumbnail Image
                      RoundedImage(
                        imageUrl: imageUrl,
                        applyImageRadius: true,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: TSizes.spaceBtwItems / 4),

                /// -  Details
                Padding(
                  padding: EdgeInsets.only(left: TSizes.md / 1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// - Product Title
                      Container(
                        padding: EdgeInsets.only(right: TSizes.sm),
                        child: TProductTitleText(
                          title: title,
                          smallSize: true,
                        ),
                      ),

                      SizedBox(height: TSizes.spaceBtwItems / 2),

                      /// - Product Description
                      Container(
                        width: 150,
                        child: Text(
                          description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .apply(fontSizeFactor: 0.8),
                        ),
                      ),

                      SizedBox(height: TSizes.spaceBtwItems, width: TSizes.xs),

                      /// - Product Price and Add to cart
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// Price
                          TProductPriceText(price: price),

                          /// - Add to cart button
                          GestureDetector(
                            onTap: onPressed,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: TColors.primary,
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(TSizes.cardRadiusMd),
                                    bottomRight: Radius.circular(
                                        TSizes.productImageRadius),
                                  )),
                              child: SizedBox(
                                width: TSizes.iconLg * 1.2,
                                height: TSizes.iconLg * 1.2,
                                child: Center(
                                  child: Icon(
                                    Iconsax.add,
                                    color: TColors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/components/TicketBuilder/widget/border_painter.dart';
import 'package:sdurian/components/TicketBuilder/widget/ticket_clipper.dart';
import 'package:sdurian/components/widgets/product_price_text.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';

class TicketUi extends StatelessWidget {
  const TicketUi({
    super.key,
    required this.name,
    required this.date,
    required this.time,
    required this.person,
    required this.price,
    this.onTap,
  });

  final String name;
  final DateTime date;
  final String time;
  final String person;
  final double price;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    String formattedDate = DateFormat('dd MMM yyyy').format(date);

    double ticketHeight = 150;

    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: TSizes.defaultSpace, vertical: TSizes.spaceBtwItems),
      child: PhysicalShape(
        color: TColors.white,
        elevation: 4,
        shadowColor: Color(0xFFE4E4E4).withOpacity(0.5),
        clipper: TicketClipper(),
        child: Stack(
          children: <Widget>[
            ClipPath(
              clipper: TicketClipper(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: ticketHeight,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0)),
              ),
            ),
            CustomPaint(
              painter: BorderPainter(),
              child: Container(
                height: ticketHeight,
                width: MediaQuery.of(context).size.width,
              ),
            ),
            // Adding ticket information using a Column wrapped in a Container
            Positioned.fill(
              child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge!
                              .apply(fontWeightDelta: 2),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 8),
                                Text(
                                  'Date: $formattedDate',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  'Time: $time',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                Text(
                                  'No. of Visitors: $person',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                SizedBox(height: TSizes.xs),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Price : ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                    TProductPriceText(price: price),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Adding buy button wrapped in a Container inside a Row
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                  width: 70,
                  height: ticketHeight,
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      primary: TColors.primary, // background color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Iconsax.add,
                        color: TColors.white,
                        size: TSizes.xl,
                      ),
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

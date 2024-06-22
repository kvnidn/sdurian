import 'package:elegant_notification/elegant_notification.dart';
import 'package:elegant_notification/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/size_config.dart';
import 'package:sdurian/utils/constants/colors.dart';

class Body extends StatefulWidget {
  final String imgPath;
  final String name;
  final double price;
  final String description;
  final String email;

  const Body(
      {Key? key,
      required this.imgPath,
      required this.name,
      required this.price,
      required this.description,
      required this.email})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  bool isExpanded = false;

  final NumberFormat currencyFormatter = NumberFormat.currency(
    locale: 'id_ID',
    symbol: 'Rp. ',
    decimalDigits: 2,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: ListView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              SizedBox(
                height: 20,
              ),
              _buildProductImage(imgPath: widget.imgPath),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(
                    // top: getProportionateScreenWidth(20),
                    bottom: getProportionateScreenWidth(20)),
                padding: EdgeInsets.only(top: getProportionateScreenWidth(20)),
                width: double.infinity,
                height: getProportionateScreenHeight(475),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.7),
                      spreadRadius: 2,
                      offset: Offset(0, -4),
                      blurRadius: 5,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildProductDescription(
                      name: widget.name,
                      description: widget.description,
                    ),
                    Container(
                      width: double.infinity,
                      padding:
                          EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            currencyFormatter.format(widget.price),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: TColors.primary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              minimumSize: Size(60, 60),
                            ),
                            onPressed: () {
                              CartItem.addItemToPoodakCart(
                                imgPath: widget.imgPath,
                                name: widget.name,
                                price: widget.price,
                                description: widget.description,
                                amount: 1.0,
                                email: widget.email, // Set as 1 for now
                              );
                              ElegantNotification(
                                position: Alignment.topCenter,
                                animation: AnimationType.fromTop,
                                width: 360,
                                height: 60,
                                description: Text(
                                  "${widget.name} added to cart",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(fontWeightDelta: 2),
                                  textAlign: TextAlign.center,
                                ),
                                icon: const Icon(
                                  Icons.check_circle,
                                  color: TColors.primary,
                                ),
                                progressIndicatorColor: TColors.primary,
                              ).show(context);
                            },
                            child: Center(
                              child: Text(
                                "Add To Cart",
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildProductImage({required String imgPath}) {
    return Column(
      children: [
        SizedBox(
          width: getProportionateScreenWidth(238),
          child: AspectRatio(
            aspectRatio: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  15.0),
              child: Image.asset(imgPath),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProductDescription(
      {required String name, required String description}) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(20)),
              child: Text(
                name,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.only(
                left: getProportionateScreenWidth(35),
                right: getProportionateScreenWidth(35),
                top: 16,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isExpanded
                        ? description
                        : description.substring(0, 20) + ' ...',
                    maxLines: isExpanded ? null : 3,
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(height: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          isExpanded ? 'See less' : 'See more',
                          style: TextStyle(
                              fontWeight: FontWeight.w600, color: Colors.black),
                        ),
                        SizedBox(width: 5),
                        Icon(
                          isExpanded ? Icons.arrow_back : Icons.arrow_forward,
                          size: 12,
                          color: Colors.black,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

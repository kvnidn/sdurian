import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'components/body.dart';

class DetailsScreen extends StatelessWidget {
  static const routeName = '/details';
  final String imgPath;
  final String name;
  final double price;
  final String description;
  final String email;

  DetailsScreen(
      {required this.imgPath,
      required this.name,
      required this.price,
      required this.description,
      required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text("Item Details",
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .apply(fontWeightDelta: 2, color: TColors.black)),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF5F6F9),
      body: Body(
        imgPath: imgPath,
        name: name,
        price: price,
        description: description,
        email: email,
      ),
    );
  }
}

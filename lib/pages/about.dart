import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  final List<Map<String, String>> developers = [
    {
      'name': 'Arya Wira Kristanto',
      'image': 'lib/assets/About/A.jpg',
    },
    {
      'name': 'Devin Saputra Wijaya',
      'image': 'lib/assets/About/D.jpg',
    },
    {
      'name': 'Jason Permana',
      'image': 'lib/assets/About/J.jpg',
    },
    {
      'name': 'Kevin Jonathan JM',
      'image': 'lib/assets/About/K.jpg',
    },
    {
      'name': 'Nicholas Martin',
      'image': 'lib/assets/About/N.jpeg',
    },
  ];

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
        title: Text(
          "About Us",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(fontWeightDelta: 2),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(30.0),
          children: [
            Center(
              child: Text(
                "Meet Our Team",
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            SizedBox(
                height: TSizes
                    .spaceBtwItems), // Spacing between title and developer list
            ...developers.map((developer) {
              return Column(
                children: [
                  Container(
                    height: 90, // Adjust the height as needed
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: Padding(
                          padding: const EdgeInsets.all(
                            5.0,
                          ), // Padding around the picture
                          child: CircleAvatar(
                            backgroundImage: AssetImage(developer['image']!),
                            radius: 30,
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15.0), // Padding around the text
                          child: Text(
                            developer['name']!,
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .apply(fontWeightDelta: 1),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                      height: TSizes.xs), // Spacing between developer cards
                ],
              );
            }).toList(),
            SizedBox(
                height: TSizes
                    .spaceBtwItems), // Spacing between the last developer and the final text
            Center(
              child: Text(
                "This app was developed with love and dedication to provide the best experience for our users.",
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

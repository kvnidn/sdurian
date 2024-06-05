import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';

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
        title: const Text(
          "About",
          style: TextStyle(
              color: Colors.black, fontWeight: FontWeight.w700, fontSize: 18),
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
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20), // Spacing between title and developer list
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
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10), // Spacing between developer cards
                ],
              );
            }).toList(),
            SizedBox(
                height:
                    30), // Spacing between the last developer and the final text
            Center(
              child: Text(
                "This app was developed with love and dedication to provide the best experience for our users.",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 20), // Additional spacing at the bottom
          ],
        ),
      ),
    );
  }
}

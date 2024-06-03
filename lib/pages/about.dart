import 'package:flutter/material.dart';
import 'package:sdurian/utils/constants/colors.dart';

class About extends StatefulWidget {
  const About({Key? key}) : super(key: key);

  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
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
          child: Center(
        child: SafeArea(
            child: Container(
          child: Column(children: [
            Text(
              "This app was developed by\n• Jason Permana\n•Arya Wira Kristanto\n•Nicholas Martin\n•Kevin Jonathan JM",
              style: TextStyle(fontSize: 20),
            )
          ]),
        )),
      )),
    );
  }
}

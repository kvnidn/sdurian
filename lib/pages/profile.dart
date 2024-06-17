import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdurian/authentication.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/edit_profile.dart';
import 'package:sdurian/pages/paymentScreen.dart';
import 'package:sdurian/pages/settings.dart';
import 'package:sdurian/pages/splash/splash_screen.dart';
import 'package:sdurian/utils/constants/colors.dart';
import 'package:sdurian/utils/constants/sizes.dart';

class Profile extends StatefulWidget {
  final User user;
  const Profile({Key? key, required this.user}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(fontWeightDelta: 2),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Center(
            child: SafeArea(
          child: Column(children: [
            const SizedBox(height: 30),
            Stack(
              children: [
                SizedBox(
                  width: 150,
                  height: 150,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: const Image(
                          image: AssetImage('lib/assets/profile.jpg'))),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              widget.user.username,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.phone, size: 20, color: Colors.black),
                SizedBox(width: 10),
                Text(widget.user.phoneNumber,
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.email, size: 20, color: Colors.black),
                SizedBox(width: 10),
                Text(widget.user.email,
                    style: Theme.of(context).textTheme.titleMedium!.apply(
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black)),
              ],
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => EditProfile(user: widget.user)),
                );
              },
              child: Container(
                width: 140,
                height: 40,
                decoration: BoxDecoration(
                  color: TColors.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Edit Profile',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(fontWeightDelta: 1, color: TColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Divider(
              color: Colors.grey, // Color yang lebih samar
              thickness: 0.5, // Ketebalan divider
              indent: 50, // Jarak dari kiri
              endIndent: 50, // Jarak dari kanan
            ),
            _buildSettingsMenu(
              "Payment",
              Icons.credit_card,
              PaymentsScreen(),
            ),
            _buildSettingsMenu("Settings", FontAwesomeIcons.gear, Settings()),
          ]),
        )),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: _buildSettingsMenuLogOut(
          "Log Out",
          Icons.logout,
          SplashScreen(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _buildSettingsMenu(String name, IconData icon, Widget destination) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => destination),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: TSizes.sm),
        width: 300,
        height: 70,
        child: Row(
          children: [
            // Icon container
            Container(
              width: 50,
              height: 50,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(360),
                color: TColors.grey,
              ),
              child: Icon(
                icon,
                size: 20,
                color: TColors.black,
              ),
            ),
            SizedBox(
                width: TSizes.spaceBtwItems *
                    1.2), // Add some space between icon and text
            // Text
            Expanded(
              child: Text(
                name,
                textAlign: TextAlign.left, // Center the text horizontally
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.grey.withOpacity(0.1),
              ),
              child: Icon(
                Icons.chevron_right,
                size: 20,
                color: TColors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsMenuLogOut(
      String name, IconData icon, Widget destination) {
    return GestureDetector(
        onTap: () {
          Auth().logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => destination),
          );
        },
        child: Container(
          width: 160,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              SizedBox(width: TSizes.spaceBtwItems),
              Text(name,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .apply(color: TColors.white, fontWeightDelta: 2)),
            ],
          ),
        ));
  }
}

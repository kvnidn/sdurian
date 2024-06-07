import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sdurian/authentication.dart';
import 'package:sdurian/data.dart';
import 'package:sdurian/pages/about.dart';
import 'package:sdurian/pages/edit_profile.dart';
import 'package:sdurian/pages/splash/splash_screen.dart';
import 'package:sdurian/utils/constants/colors.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: Text("Settings"),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Align(
          alignment: Alignment.topLeft,
          child: _buildSettingsScreen(),
        ),
      ),
    );
  }

  Widget _buildSettingsScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 10),
          _buildSettingsItem("Security", Icons.security, _showSecuritySettings),
          _buildSettingsItem("FAQ", Icons.question_answer, _showFAQDialog),
          _buildSettingsItem("Terms & Conditions", Icons.assignment_outlined,
              _showTermsConditions),
          _buildSettingsItem(
              "Privacy Policy", Icons.privacy_tip_outlined, _showPrivacyPolicy),
        ],
      ),
    );
  }

  Widget _buildSettingsItem(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        children: [
          ListTileTheme(
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            child: ListTile(
              leading: Icon(icon, color: const Color(0xFF0912C7)),
              title: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(title, style: TextStyle(fontSize: 18)),
              ),
              trailing: Icon(Icons.arrow_forward),
              onTap: onTap,
            ),
          ),
          Divider(
            color: Colors.grey,
            thickness: 1,
            indent: 20,
            endIndent: 20,
          ),
        ],
      ),
    );
  }

  void _showSecuritySettings() {
    _showToast("Security Settings");
  }

  void _showFAQDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("FAQ"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildFAQItem("Q: What is Universal Poodak Studio?",
                    "A: Universal Poodak Studio is an application that offers an enjoyable experience with Poodak products and attractions from Universal Studios Singapore."),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(question, style: TextStyle(fontWeight: FontWeight.bold)),
        Text(answer),
        SizedBox(height: 10),
      ],
    );
  }

  void _showTermsConditions() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Terms & Conditions"),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("1. Introduction",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "Welcome to Universal Poodak Studio. These Terms and Conditions govern your use of the Universal Poodak Studio app. By using the app, you agree to comply with and be bound by these Terms and Conditions. If you do not agree with any part of these terms, please do not use the app."),
                SizedBox(height: 8),
                Text("2. User Registration",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "2.1. To use certain features of the app, you may be required to register for an account. You are responsible for maintaining the confidentiality of your account credentials and for all activities that occur under your account."),
                SizedBox(height: 8),
                Text(
                    "2.2. You must provide accurate and complete information during the registration process. If any information provided by you is found to be inaccurate or incomplete, we reserve the right to terminate your account."),
                SizedBox(height: 8),
                Text("3. Privacy",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "3.1. Your use of the app is also governed by our Privacy Policy, which can be found here. By using the app, you consent to the collection, use, and sharing of your information as described in the Privacy Policy."),
                SizedBox(height: 8),
                Text("4. Orders and Payments",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "4.1. When you place an order through the Universal Poodak Studio app, you are making a purchase. You agree to pay for all products ordered, including any applicable taxes."),
                SizedBox(height: 8),
                Text(
                    "4.2. Payment methods accepted by Maniere include credit cards, debit cards, and other payment options as specified in the app."),
                SizedBox(height: 8),
                Text("5. Orders and Product",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "5.1. You can cancel your order anytime you want. You can also request a refund within 7 days of delivery for a full refund or exchange, subject to our return policy. Please refer to our Return Policy for more details."),
                SizedBox(height: 8),
                Text(
                    "5.2. If you are not satisfied with your purchase, you cancel your order and rate within 7 days for a refund or exchange, subject to our return policy. Please refer to our Return Policy for more details."),
                SizedBox(height: 8),
                Text("6. Intellectual Property",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "6.1. The content, images, logos, and trademarks displayed on the Universal Poodak Studio app are the property of Universal Poodak Studio or its affiliates. You may not use, reproduce, or distribute any of these materials without our express written permission."),
                SizedBox(height: 8),
                Text("7. User Conduct",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "7.1. You agree to use the app only for lawful purposes and in compliance with these Terms and Conditions. You may not engage in any activity that could harm the app or interfere with its proper functioning."),
                SizedBox(height: 8),
                Text("8. Termination",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "8.1. Universal Poodak Studio reserves the right to terminate or suspend your access to the app at any time and for any reason, including violations of these Terms and Conditions."),
                SizedBox(height: 8),
                Text("9. Changes to Terms and Conditions",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "9.1. Universal Poodak Studio may update these Terms and Conditions from time to time. You are encouraged to review them periodically. Your continued use of the app after changes are made constitutes your acceptance of the revised Terms and Conditions."),
                SizedBox(height: 8),
                Text("10. Contact Information",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text(
                    "10.1. If you have any questions or concerns regarding these Terms and Conditions, please contact us at UPS@stu.untar.ac.id."),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showPrivacyPolicy() {
    _showToast("Privacy Policy");
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.black,
      textColor: Colors.white,
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: Settings(),
  ));
}

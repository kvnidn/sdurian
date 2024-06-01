import 'package:flutter/material.dart';
import 'package:sdurian/data.dart';

import 'components/body.dart';

class LogInScsScreen extends StatelessWidget {
  static String routeName = "/loginscs";

  final User user;

  LogInScsScreen({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user: user),
    );
  }
}

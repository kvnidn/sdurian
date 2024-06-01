import 'package:flutter/material.dart';
import 'package:sdurian/components/form_error.dart';
import 'package:sdurian/components/no_account.dart';
import 'package:sdurian/constants.dart';
import 'package:sdurian/size_config.dart';

import '../../../components/default_button.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(20)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: getProportionateScreenHeight(30)),
                Container(
                  height: getProportionateScreenHeight(72.15),
                  width: getProportionateScreenWidth(66),
                  child: Image.asset(
                    "lib/assets/durianking.png",
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(20)),
                Text(
                  "Forgot Password",
                  style: headingStyle,
                ),
                SizedBox(height: getProportionateScreenHeight(10)),
                Text(
                  "Please enter your email and we will send \nyou a link to reset your password",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: kTextLightColor,
                  ),
                ),
                SizedBox(height: getProportionateScreenHeight(25)),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(18),
                  ),
                  child: ForgotPwForm(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ForgotPwForm extends StatefulWidget {
  @override
  State<ForgotPwForm> createState() => _ForgotPwFormState();
}

class _ForgotPwFormState extends State<ForgotPwForm> {
  final _formKey = GlobalKey<FormState>();
  List<String> errors = [];
  late String email;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (newValue) => email = newValue!,
              onChanged: (value) {
                if (value.isNotEmpty && errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.remove(kEmailNullError);
                  });
                } else if (value.isEmpty ||
                    emailValidatorRegExp.hasMatch(value) &&
                        errors.contains(kInvalidEmailError)) {
                  setState(() {
                    errors.remove(kInvalidEmailError);
                  });
                }
                return null;
              },
              style: TextStyle(
                color: kTextLightColor,
              ),
              validator: (value) {
                if ((value == null || value.isEmpty) &&
                    !errors.contains(kEmailNullError)) {
                  setState(() {
                    errors.add(kEmailNullError);
                  });
                } else if ((value != null && !value.isEmpty) &&
                    !emailValidatorRegExp.hasMatch(value) &&
                    !errors.contains(kInvalidEmailError)) {
                  setState(() {
                    errors.add(kInvalidEmailError);
                  });
                }
                return null;
              },
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: TextStyle(
                  color: kTextLightColor,
                ),
                hintText: "Enter your email",
                hintStyle: TextStyle(
                    color: kTextLightColor,
                    fontWeight: FontWeight.w300,
                    fontSize: 14),
                floatingLabelBehavior: FloatingLabelBehavior.always,
              )),
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(56),
            ),
            child: FormError(errors: errors),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Continue",
            press: () {
              if (_formKey.currentState?.validate() ?? false) {}
            },
          ),
          SizedBox(height: getProportionateScreenHeight(35)),
          noAccount(),
          SizedBox(height: getProportionateScreenHeight(38)),
        ],
      ),
    );
  }
}

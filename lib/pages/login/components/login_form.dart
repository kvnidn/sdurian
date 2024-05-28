import 'package:flutter/material.dart';
import 'package:sdurian/pages/forgotpw/forgotpw.dart';
import 'package:sdurian/pages/loginsuccess/loginscs.dart';

import '../../../components/default_button.dart';
import '../../../components/form_error.dart';
import '../../../constants.dart';
import '../../../size_config.dart';

class LogInForm extends StatefulWidget {
  const LogInForm({super.key});

  @override
  State<LogInForm> createState() => _LogInFormState();
}

class _LogInFormState extends State<LogInForm> {
  final _formKey = GlobalKey<FormState>();

  String email_default = "sdurian@gmail.com";
  String pw_default = "sdurian88";

  late String email;
  late String password;
  bool remember = false;
  final List<String> errors = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildEmailFormField(),
          ),
          SizedBox(height: getProportionateScreenHeight(25)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(18),
            ),
            child: buildPasswordFormField(),
          ),
          SizedBox(height: getProportionateScreenHeight(20)),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(62),
            ),
            child: FormError(errors: errors),
          ),
          SizedBox(height: getProportionateScreenHeight(10)),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getProportionateScreenWidth(8)
                ),
                child: Checkbox(
                  value: remember,
                  activeColor: kPrimaryColor,
                  checkColor: Colors.white,
                  onChanged: (value) {
                    setState(() {
                      remember = value!;
                    });
                  },
                ),
              ),
              Text(
                "Remember me",
                style: TextStyle(
                  color: kTextLightColor,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Navigator.pushNamed(
                  context, ForgotPwScreen.routeName
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getProportionateScreenWidth(20.5),
                  ),
                  child: Text(
                    "Forgot Password",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: kTextLightColor,
                    ),
                  ),
                ),
              ),
            ]
          ),
          SizedBox(height: getProportionateScreenHeight(28)),
          DefaultButton(
            text: "Log In",
            press: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                // Setelah data divalidasi dan valid, akan didirect ke tampilan login success
                Navigator.pushNamed(context, LogInScsScreen.routeName);
              }
            },
          ),
        ],
      )
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
          obscureText: true,
          onSaved:(newValue) => password = newValue!,
          onChanged: (value) {
            if (value.isNotEmpty && errors.contains(kPassNullError)) {
              setState(() {
                errors.remove(kPassNullError);
              });
            }
            else if (value.isEmpty || value.length >= 8 && errors.contains(kShortPassError)) {
              setState(() {
                errors.remove(kShortPassError);
              });
            }
            return null;
          },
          validator: (value) {
            if ((value == null || value.isEmpty) && !errors.contains(kPassNullError)) {
              setState(() {
                errors.add(kPassNullError);
              });
            }
            else if ((value != null && !value.isEmpty) && value.length < 8 && !errors.contains(kShortPassError)) {
              setState(() {
                errors.add(kShortPassError);
              });
            }
            return null;
          },
          style: TextStyle(
            color: kTextLightColor,
          ),
          decoration: InputDecoration(
            labelText: "Password",
            labelStyle: TextStyle(
              color: kTextLightColor,
            ),
            hintText: "Enter your password",
            hintStyle: TextStyle(
              color: kTextLightColor,
              fontWeight: FontWeight.w300,
              fontSize: 14,
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          )
        );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
          keyboardType: TextInputType.emailAddress,
          onSaved: (newValue) => email = newValue!,
          onChanged: (value) {
            if (value.isNotEmpty && errors.contains(kEmailNullError)) {
              setState(() {
                errors.remove(kEmailNullError);
              });
            }
            else if (value.isEmpty || emailValidatorRegExp.hasMatch(value) && errors.contains(kInvalidEmailError)) {
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
            if ((value == null || value.isEmpty) && !errors.contains(kEmailNullError)) {
              setState(() {
                errors.add(kEmailNullError);
              });
            }
            else if ((value != null && !value.isEmpty) && !emailValidatorRegExp.hasMatch(value) && !errors.contains(kInvalidEmailError)) {
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
              fontSize: 14
            ),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          )
        );
  }
}
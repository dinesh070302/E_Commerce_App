import 'package:e_commerce_website/Widgets/custom_button.dart';
import 'package:e_commerce_website/Widgets/custom_input.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:e_commerce_website/screens/register_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.only(top: 24.0),
              child: const Text(
                "Welcome User,\n Login to your account",
                textAlign: TextAlign.center,
                style: Constants.boldHeading,
              ),
            ),
            Column(
              children: [
                CustomInput(
                  hintText: "Email...",
                ),
                CustomInput(
                  hintText: "Password...",
                ),
                CustomButton(
                  text: "Log In",
                  onPressed: () {},
                  outlineButton: false,
                  isFormLoading: false,
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: CustomButton(
                isFormLoading: false,
                text: "Create New Account",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RegisterPage(),
                    ),
                  );
                },
                outlineButton: true,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

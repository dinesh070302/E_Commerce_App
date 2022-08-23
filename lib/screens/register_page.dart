import 'package:e_commerce_website/Widgets/custom_button.dart';
import 'package:e_commerce_website/Widgets/custom_input.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                "Create a New Account",
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
                    text: "Register", onPressed: () {}, outlineButton: false)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomButton(
                text: "Back to Login",
                onPressed: () {
                  Navigator.pop(context);
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

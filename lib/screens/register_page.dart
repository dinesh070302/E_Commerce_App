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
  Future<void> _alertDialogBuilder() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text("Dummy Text for this moment"),
            ),
            actions: [
              TextButton(
                child: Text("Close Alert"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    bool loadingForRegister = false;

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
                    text: "Register",
                    onPressed: () {
                      print("Register button Clicked");
                      setState(() {
                        print("Enterd");
                        loadingForRegister = true;
                      });
                      // _alertDialogBuilder();
                    },
                    isFormLoading: loadingForRegister,
                    outlineButton: false)
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomButton(
                isFormLoading: false,
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

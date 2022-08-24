import 'package:e_commerce_website/Widgets/custom_button.dart';
import 'package:e_commerce_website/Widgets/custom_input.dart';
import 'package:e_commerce_website/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
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

  //Create new user
  Future<String?> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPassword);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exits for the mail';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    //set the form to loading state
    setState(() {
      loadingForRegister = true;
    });

    //Create new account function call
    String? _createAccountFeedback = await _createAccount();

    // if recieve some error
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
      //set the loading state to false because of thye dialog
      setState(() {
        loadingForRegister = false;
      });
    } else {
      //As the string is empty beacuse of no errors we close the login screens and head to homepage
      Navigator.pop(context);
    }
  }

  bool loadingForRegister = false;

  //Form Input Field variables
  String _registerEmail = "";
  String _registerPassword = "";

  //focusNodes for input fields
  late FocusNode _passwordFocusNode;

  @override
  void initState() {
    // TODO: implement initState
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _passwordFocusNode.dispose();
    super.dispose();
  }

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
                  isPasswordField: false,
                  hintText: "Email...",
                  onChanged: (value) {
                    _registerEmail = value;
                  },
                  onSubmitted: (value) {
                    _passwordFocusNode.requestFocus();
                  },
                  textInputAction: TextInputAction.next,
                ),
                CustomInput(
                  isPasswordField: true,
                  hintText: "Password...",
                  onChanged: (value) {
                    _registerPassword = value;
                  },
                  focusNode: _passwordFocusNode,
                  onSubmitted: (value) {
                    _submitForm();
                  },
                ),
                CustomButton(
                    text: "Register",
                    onPressed: () {
                      _submitForm();
                      // print("Register button Clicked");
                      // setState(() {
                      //   print("Enterd");
                      //   loadingForRegister = true;
                      // });
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
